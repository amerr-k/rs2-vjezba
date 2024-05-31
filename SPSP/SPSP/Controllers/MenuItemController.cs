using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models.Request.MenuItem;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;
using SPSP.Services.MenuItem;

namespace SPSP.Controllers
{
    [ApiController] // mora ostati u konkretnom kontroleru zbog swaggera
    public class MenuItemController
        : BaseCRUDController<Models.MenuItem, MenuItemSearchObject, MenuItemCreateRequest, MenuItemUpdateRequest>
    {

        public MenuItemController(ILogger<BaseCRUDController<Models.MenuItem, MenuItemSearchObject, MenuItemCreateRequest, MenuItemUpdateRequest>> logger,
            IMenuItemService service)
            : base(logger, service)
        {
 
        }

    }
}
