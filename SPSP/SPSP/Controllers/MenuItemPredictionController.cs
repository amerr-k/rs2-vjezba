using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models;
using SPSP.Models.Request.MenuItem;
using SPSP.Models.SearchObjects;
using SPSP.Services.Category;
using SPSP.Services.MenuItem;

namespace SPSP.Controllers
{
    [ApiController]
    public class MenuItemPredictionController : BaseController<MenuItemPrediction, BaseSearchObject>
    {

        private readonly IMenuItemPredictionService service;

        public MenuItemPredictionController(ILogger<BaseController<MenuItemPrediction, BaseSearchObject>> logger,
            IMenuItemPredictionService service)
            : base(logger, service)
        {
            this.service = service;
        }

        [HttpGet("GetByMainMenuItemId/{mainMenuItemId}")]
        public async Task<List<Models.MenuItemPrediction>> GetByMainMenuId(int mainMenuItemId)
        {
            return await service.GetByMainMenuItemId(mainMenuItemId);
        }

    }
}
