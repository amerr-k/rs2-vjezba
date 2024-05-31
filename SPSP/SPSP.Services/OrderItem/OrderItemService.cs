using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.OrderItem;

namespace SPSP.Services.OrderItem
{
    public class OrderItemService : BaseService<Models.OrderItem, Database.OrderItem, BaseSearchObject>, IOrderItemService
    {

        public OrderItemService(DataDbContext context, IMapper mapper) 
            : base(context, mapper)
        {
           
        }

        public async Task<List<Models.OrderItem>> CreateMultiple(IEnumerable<OrderItemCreateRequest> orderItems, int orderId)
        {
            var orderItemEntities = new List<Database.OrderItem>();

            foreach (var item in orderItems)
            {
                var orderItemEntity = mapper.Map<Database.OrderItem>(item);
                orderItemEntity.OrderId = orderId;
                orderItemEntities.Add(orderItemEntity);
            }

            context.OrderItems.AddRange(orderItemEntities);
            await context.SaveChangesAsync();
             return mapper.Map<List<Models.OrderItem>>(orderItemEntities);
        }
    }
}
