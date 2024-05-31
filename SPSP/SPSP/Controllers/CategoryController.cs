using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models;
using SPSP.Models.SearchObjects;
using SPSP.Services.Category;

namespace SPSP.Controllers
{
    [ApiController]
    public class CategoryController : BaseController<Category, BaseSearchObject>
    {

        public CategoryController(ILogger<BaseController<Category, BaseSearchObject>> logger,
            ICategoryService service)
            : base(logger, service)
        {

        }

    }
}
