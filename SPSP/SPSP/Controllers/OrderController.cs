using Microsoft.AspNetCore.Mvc;
using SPSP.Controllers.Base;
using SPSP.Models.Request.Order;
using SPSP.Models.SearchObjects;
using SPSP.Services.Order;

namespace SPSP.Controllers
{
    [ApiController]

    public class OrderController : BaseCRUDController<Models.Order, OrderSearchObject, OrderCreateRequest, OrderUpdateRequest>
    {

        private readonly IOrderService orderService;

        public OrderController(ILogger<BaseCRUDController<Models.Order, OrderSearchObject, OrderCreateRequest, OrderUpdateRequest>> logger, IOrderService service)
            : base(logger, service)
        {
            this.orderService = service;
        }

        [HttpPut("{id}/cancel")]
        public virtual async Task<Models.Order> CancelOrder(int id)
        {
            return await orderService.CancelOrder(id);
        }

        [HttpPut("{id}/complete")]
        public virtual async Task<Models.Order> CompleteOrder(int id)
        {
            return await orderService.CompleteOrder(id);
        }

    }
}


//[HttpPost]
//public async Task<Models.Order> Insert()
//{
//    return await (service as IOrderService).Insert(); 
//bolje je da ako ce se ovaj servis koristit umjesto casta kreirati properti service na nivou ovog kontrolera
//}

//[HttpPost]
//public async Task<Models.Order> Insert()
//{
//    return await service.Insert();
//    
//}