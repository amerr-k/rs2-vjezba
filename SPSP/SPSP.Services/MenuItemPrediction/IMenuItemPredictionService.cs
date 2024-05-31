using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.Category
{
    public interface IMenuItemPredictionService : IService<Models.MenuItemPrediction, BaseSearchObject>
    {
        public Task<List<Models.MenuItemPrediction>> GetByMainMenuItemId(int mainMenuItemId);
    }
}
