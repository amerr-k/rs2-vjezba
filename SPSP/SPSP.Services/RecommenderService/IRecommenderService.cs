using SPSP.Models;

namespace SPSP.Services.RecommenderService
{
    public interface IRecommenderService
    {
        public void Recommend();
        public List<MenuItemPrediction> GetRecommendedMenuItems(int id);
    }
}
