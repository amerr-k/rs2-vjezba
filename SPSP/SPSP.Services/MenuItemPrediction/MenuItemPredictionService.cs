using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using Microsoft.EntityFrameworkCore;

namespace SPSP.Services.Category
{
    public class MenuItemPredictionService : BaseService<Models.MenuItemPrediction, Database.MenuItemPrediction, BaseSearchObject>, IMenuItemPredictionService
    {
        public MenuItemPredictionService(DataDbContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public async Task<List<Models.MenuItemPrediction>> GetByMainMenuItemId(int mainMenuItemId)
        {
            var menuItemPredictions = context.MenuItemPredictions
                .Where(x => x.MainMenuItemId == mainMenuItemId)
                .Include(x => x.RecommendedMenuItem)
                .ToList();

            return mapper.Map<List<Models.MenuItemPrediction>>(menuItemPredictions);
        }
    }
}

