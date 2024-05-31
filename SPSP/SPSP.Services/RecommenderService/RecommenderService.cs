using AutoMapper;
using Microsoft.ML.Trainers;
using Microsoft.ML;
using SPSP.Services.Database;
using Microsoft.EntityFrameworkCore;
using static SPSP.Services.RecommenderService.RecommenderModels;
using System.IO;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;

namespace SPSP.Services.RecommenderService
{
    public class RecommenderService : IRecommenderService
    {

        protected readonly MLContext mlContext;
        protected readonly DataDbContext context;
        protected readonly IMapper mapper;
        protected readonly ILogger<RecommenderService> logger;

        public RecommenderService(MLContext mlContext, DataDbContext context, IMapper mapper, ILogger<RecommenderService> logger)
        {
            this.mlContext = mlContext;
            this.context = context;
            this.mapper = mapper;
            this.logger = logger;
        }

        public void Recommend()
        {
            logger.LogInformation("Recommend");

            var trainedData = Train();

            Predict(trainedData);
        }

        public TrainedData Train()
        {
            var memoryStream = new MemoryStream();
            var tmpData = context.Orders.Include("OrderItems").ToList();
            var data = new List<ProductEntry>();

            foreach (var x in tmpData)
            {
                if (x.OrderItems.Count > 1)
                {
                    var distinctItemId = x.OrderItems.Select(y => y.MenuItemId).ToList();

                    distinctItemId.ForEach(y =>
                    {
                        var relatedItems = x.OrderItems.Where(z => z.MenuItemId != y);

                        foreach (var z in relatedItems)
                        {
                            data.Add(new ProductEntry()
                            {
                                ProductID = (uint)y,
                                CoPurchaseProductID = (uint)z.MenuItemId,
                            });
                        }
                    });
                }
            }

            var traindata = mlContext.Data.LoadFromEnumerable(data);

            if(tmpData != null && !data.IsNullOrEmpty())
            {
                MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                options.LabelColumnName = "Label";
                options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                options.Alpha = 0.01;
                options.Lambda = 0.025;
                options.NumberOfIterations = 100;
                options.C = 0.00001;

                var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                ITransformer model = est.Fit(traindata);

                mlContext.Model.Save(model, traindata.Schema, memoryStream);

                var trainedData = new TrainedData
                {
                    Data = memoryStream.ToArray(),
                    TrainedDateTime = DateTime.Now,
                };

                context.TrainedDatas.Add(trainedData);

                context.SaveChanges();
                return trainedData;
            }

            return null;
        }

        public void Predict(TrainedData trainedData)
        {
            if(trainedData != null)
            {
                var memoryStream = new MemoryStream(trainedData.Data);
                var t2Model = mlContext.Model.Load(memoryStream, out DataViewSchema schema);

                var menuItemsFirstList = context.MenuItems.ToList();
                var menuItemPredictionResultList = new List<MenuItemPrediction>();
                foreach (var outerMenuItem in menuItemsFirstList)
                {
                    var menuItemsSecondList = context.MenuItems.Where(x => x.Id != outerMenuItem.Id);

                    var predictionResult = new List<Tuple<Database.MenuItem, float>>();

                    foreach (var nestedMenuItem in menuItemsSecondList)
                    {

                        var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(t2Model);
                        var prediction = predictionengine.Predict(
                                                 new ProductEntry()
                                                 {
                                                     ProductID = (uint)outerMenuItem.Id,
                                                     CoPurchaseProductID = (uint)nestedMenuItem.Id
                                                 });

                        predictionResult.Add(new Tuple<Database.MenuItem, float>(nestedMenuItem, prediction.Score));
                    }

                    var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(2).ToList();

                    foreach (var item in finalResult)
                    {
                        var prediction = new MenuItemPrediction();
                        prediction.MainMenuItemId = outerMenuItem.Id;
                        prediction.RecommendedMenuItemId = item.Id;
                        menuItemPredictionResultList.Add(prediction);
                    }
                }
                var allEntities = context.MenuItemPredictions.ToList();
                context.MenuItemPredictions.RemoveRange(allEntities);
                context.SaveChanges();
                context.MenuItemPredictions.AddRange(menuItemPredictionResultList);
                context.SaveChanges();
            }
        }


        public List<Models.MenuItemPrediction> GetRecommendedMenuItems(int menuItemId)
        {
            var menuItems = context.MenuItemPredictions
                .Include(x => x.RecommendedMenuItem)
                .Where(x => x.MainMenuItemId == menuItemId)
                .ToList();

            return mapper.Map<List<Models.MenuItemPrediction>>(menuItems);
        }
    }
}
