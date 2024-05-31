using Microsoft.AspNetCore.Mvc;
using SPSP.Controllers.Base;
using SPSP.Models;
using SPSP.Models.SearchObjects;
using SPSP.Services.OrderItem;

namespace SPSP.Controllers
{
    [ApiController]
    public class OrderItemController : BaseController<OrderItem, BaseSearchObject>
    {

        public OrderItemController(ILogger<BaseController<OrderItem, BaseSearchObject>> logger,
            IOrderItemService service)
            : base(logger, service)
        {
 
        }

    }
}
