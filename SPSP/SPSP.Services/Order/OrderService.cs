using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.Order;
using SPSP.Services.OrderItem;
using SPSP.Services.QRTable;
using SPSP.Models.Enums;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using SPSP.Services.Customer;

namespace SPSP.Services.Order
{
    public class OrderService 
        : BaseCRUDService<Models.Order, Database.Order, OrderSearchObject, OrderCreateRequest, OrderUpdateRequest>, IOrderService
    {
        protected readonly IOrderItemService orderItemService;
        protected readonly ICustomerService customerService;
        protected readonly IQRTableService qrTableService;
        private readonly IHttpContextAccessor httpContextAccessor;
        public OrderService(DataDbContext context, IMapper mapper, IOrderItemService orderItemService, IQRTableService qrTableService, IHttpContextAccessor httpContextAccessor, ICustomerService customerService) 
            : base(context, mapper)
        {
            this.orderItemService = orderItemService;
            this.qrTableService = qrTableService;
            this.httpContextAccessor = httpContextAccessor;
            this.customerService = customerService;
        }

        public override IQueryable<Database.Order> AddInclude(IQueryable<Database.Order> query, OrderSearchObject search = null)
        {
            if (search.IsOrderItemsIncluded == true)
            {
                query = query.Include(x => x.OrderItems) 
                            .ThenInclude(o => o.MenuItem)
                            .ThenInclude(c => c.Category);
            }

            if (search.IsQRTablesIncluded == true)
            {
                query = query.Include(x => x.QRTable);
            }

            return base.AddInclude(query, search);
        }

        public override async Task<Models.Order> Create(OrderCreateRequest create)
        {
            var orderEntity = mapper.Map<Database.Order>(create);
            orderEntity.Status = OrderStatusEnumExtension.GetValue(OrderStatusEnum.ACTIVE);

            context.Orders.Add(orderEntity);
            await context.SaveChangesAsync();

            List<Models.OrderItem> orderItems;
            var order = mapper.Map<Models.Order>(orderEntity);
            
            //if (create.OrderItems  != null)
            //{
            //    orderItems = await orderItemService.CreateMultiple(create.OrderItems, orderEntity.Id);
            //    order.OrderItems = orderItems;
            //}

            await qrTableService.SetIsTaken(create.QRTableId, true);

            return order;
        }

        public override IQueryable<Database.Order> AddFilter(IQueryable<Database.Order> query, OrderSearchObject search)
        {
            if (search?.SearchByCustomer != null)
            {
                var principal = httpContextAccessor.HttpContext?.User;
                var userId = principal?.FindFirst(ClaimTypes.NameIdentifier)?.Value;

                query = query.Where(x => x.Customer.UserAccountId == int.Parse(userId!));
            }

            if (search?.orderStatus != null)
            {
                query = query.Where(x => x.Status.Equals(search.orderStatus.ToString()));
            }

            if (search?.orderDateTimeFrom != null || search?.orderDateTimeTo != null)
            {
                if (search.orderDateTimeFrom != null && search.orderDateTimeTo != null)
                {
                    query = query.Where(x => x.OrderDateTime.Date >= search.orderDateTimeFrom.Value.Date && x.OrderDateTime.Date <= search.orderDateTimeTo.Value.Date);
                }
                else if (search.orderDateTimeFrom != null)
                {
                    query = query.Where(x => x.OrderDateTime.Date >= search.orderDateTimeFrom.Value.Date);
                }
                else if (search.orderDateTimeTo != null)
                {
                    query = query.Where(x => x.OrderDateTime.Date <= search.orderDateTimeTo.Value.Date);
                }
            }

            if (search?.QRTableId != null)
            {
                query = query.Where(x => x.QRTableId == search.QRTableId);
            }


            return base.AddFilter(query, search);
        }

        public async Task<Models.Order> UpdateStatusAndCustomer(int orderId, OrderStatusEnum orderStatus, int customerId)
        {

            var orderEntity = await context.Orders.FindAsync(orderId);
            if (orderEntity != null)
            {
                orderEntity.Status = OrderStatusEnumExtension.GetValue(orderStatus);
                orderEntity.CustomerId = customerId;
            }

            await context.SaveChangesAsync();

            return mapper.Map<Models.Order>(orderEntity);
        }

        public async Task<Models.Order> CancelOrder(int id)
        {
            var orderEntity = await context.Orders.FindAsync(id);
            if (orderEntity != null)
            {
                orderEntity.Status = OrderStatusEnumExtension.GetValue(OrderStatusEnum.CANCELED);
            }
            await context.SaveChangesAsync();

            return mapper.Map<Models.Order>(orderEntity);
        }

        public async Task<Models.Order> CompleteOrder(int id)
        {
            var orderEntity = await context.Orders.FindAsync(id);
            if (orderEntity != null)
            {
                orderEntity.Status = OrderStatusEnumExtension.GetValue(OrderStatusEnum.COMPLETED);
            }
            await context.SaveChangesAsync();

            return mapper.Map<Models.Order>(orderEntity);
        }
    }
}
