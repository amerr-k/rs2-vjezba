using SPSP.Models.Request.OrderItem;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.OrderItem
{
    public interface IOrderItemService 
        : IService<Models.OrderItem, BaseSearchObject>
    {
        public Task<List<Models.OrderItem>> CreateMultiple(IEnumerable<OrderItemCreateRequest> orderItems, int orderId);
    }
}
