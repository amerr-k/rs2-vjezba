using SPSP.Models.SearchObjects;
using System.Threading.Tasks;
using SPSP.Services.Base;
using SPSP.Models.Request.Order;
using SPSP.Models.Enums;

namespace SPSP.Services.Order
{
    public interface IOrderService 
        : ICRUDService<Models.Order, OrderSearchObject, OrderCreateRequest, OrderUpdateRequest>
    {
        Task<Models.Order> CancelOrder(int id);
        Task<Models.Order> CompleteOrder(int id);
        Task<Models.Order> UpdateStatusAndCustomer(int orderId, OrderStatusEnum orderStatus, int customerId);
    }
}
