using Microsoft.AspNetCore.Mvc;
using SPSP.Controllers.Base;
using SPSP.Models.SearchObjects;
using SPSP.Services.Menu;

namespace SPSP.Controllers
{
    [ApiController]
    public class MenuController : BaseController<Models.Menu, MenuSearchObject>
    {

        public MenuController(ILogger<BaseController<Models.Menu, MenuSearchObject>> logger,
            IMenuService service)
            : base(logger, service)
        {
 
        }

    }
}
