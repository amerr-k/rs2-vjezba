using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.Promotion;
using SPSP.Services.RecommenderService;

namespace SPSP.Services.Promotion
{


    public class PromotionService : BaseCRUDService<Models.Promotion, Database.Promotion, PromotionSearchObject, PromotionCreateRequest, PromotionUpdateRequest>, IPromotionService
    {

        public PromotionService(DataDbContext context, IMapper mapper, IRecommenderService recommenderService)
            : base(context, mapper)
        {
        }


        public override IQueryable<Database.Promotion> AddFilter(IQueryable<Database.Promotion> query, PromotionSearchObject search)
        {
            if (search.IsOnlyTodaysIncluded != null && search.IsOnlyTodaysIncluded == true)
            {
                var today = DateTime.Now.Date;
                query = query.Where(x => x.StartTime.Date <= today && (x.EndTime == null || x.EndTime >= today) && x.Active);
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Include(x=>x.MenuItem).Where(x => x.Description != null && x.Description.Contains(search.FTS) || x.MenuItem.Name.Contains(search.FTS));
            }


            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Promotion> AddInclude(IQueryable<Database.Promotion> query, PromotionSearchObject search = null)
        {

            query = query.Include(x => x.MenuItem);

            return base.AddInclude(query, search);
        }
    }


}

