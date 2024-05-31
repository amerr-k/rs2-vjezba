using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.SaleInvoice;
using SPSP.Models.SearchObjects;
using SPSP.Services.SaleInvoiceItem;
using SPSP.Services.PaymentGatewayData;
using SPSP.Services.Order;
using SPSP.Models.Enums;
using SPSP.Services.OrderEmailPublisher;
using SPSP.Services.Customer;

namespace SPSP.Services.SaleInvoice
{
    public class SaleInvoiceService
        : BaseCRUDService<Models.SaleInvoice, Database.SaleInvoice, SaleInvoiceSearchObject, SaleInvoiceCreateRequest, Object>, ISaleInvoiceService
    {
        protected readonly ISaleInvoiceItemService saleInvoiceItemService;
        protected readonly IPaymentGatewayDataService paymentGatewayDataService;
        protected readonly IOrderService orderService;
        protected readonly ICustomerService customerService;
        protected readonly IEmailPublisherService emailPublisherService;

        public SaleInvoiceService(DataDbContext context, IMapper mapper, ISaleInvoiceItemService saleInvoiceItemService, IPaymentGatewayDataService paymentGatewayDataService, IOrderService orderService, IEmailPublisherService emailPublisherService, ICustomerService customerService) 
            : base(context, mapper)
        {
            this.saleInvoiceItemService = saleInvoiceItemService;
            this.paymentGatewayDataService = paymentGatewayDataService;
            this.orderService = orderService;
            this.emailPublisherService = emailPublisherService;
            this.customerService = customerService;
        }

        public override IQueryable<Database.SaleInvoice> AddInclude(IQueryable<Database.SaleInvoice> query, SaleInvoiceSearchObject search = null)
        {
            if (search.IsSaleInvoiceItemsIncluded == true)
            {
                query = query.Include(x => x.SaleInvoiceItems) 
                            .ThenInclude(o => o.MenuItem)
                            .ThenInclude(c => c.Category);
            }

            return base.AddInclude(query, search);
        }

        public override async Task<Models.SaleInvoice> Create(SaleInvoiceCreateRequest create)
        {
            var saleInvoiceEntity = mapper.Map<Database.SaleInvoice>(create);
            saleInvoiceEntity.InvoiceNumber = createInvoiceNumber();

            context.SaleInvoices.Add(saleInvoiceEntity);

            await context.SaveChangesAsync();

            List<Models.SaleInvoiceItem> saleInvoiceItems;
            var saleInvoice = mapper.Map<Models.SaleInvoice>(saleInvoiceEntity);

            if (create.PaymentGatewayData != null)
            {
                var paymentGatewayData = await paymentGatewayDataService.Create(create.PaymentGatewayData);
                saleInvoice.PaymentGatewayData = paymentGatewayData;
            }
            await context.SaveChangesAsync();

            var customer = customerService.GetCustomerAccountInfo();

            if (saleInvoiceEntity.Processed != null && saleInvoiceEntity.Processed == true)
            {
                await orderService.UpdateStatusAndCustomer(saleInvoiceEntity.OrderId, OrderStatusEnum.COMPLETED, customer.Id);
            }
            else
            {
                await orderService.UpdateStatusAndCustomer(saleInvoiceEntity.OrderId, OrderStatusEnum.FAILED, customer.Id);
            }

            createSaleInvoiceEmail(create.PdfInvoice);

            return saleInvoice;
        }

        private string createInvoiceNumber()
        {
            var uniqueIdentifier = Guid.NewGuid();
            return $"{DateTime.UtcNow:yyyyMMddHHmm}_{uniqueIdentifier}";
        }

        public override IQueryable<Database.SaleInvoice> AddFilter(IQueryable<Database.SaleInvoice> query, SaleInvoiceSearchObject search)
        {

            return base.AddFilter(query, search);
        }

        private void createSaleInvoiceEmail(byte[] PdfInvoice)
        {
            var emailMessage = new Models.EmailMessage {
                Subject = "Skeniraj - pogledaj - skeniraj - plati",
                Body = "Hvala vam na povjerenju. Dođite nam opet", 
                PdfAttachment = PdfInvoice
            };

            emailPublisherService.PublishSaleInvoiceEmail(emailMessage);

        }
    }
}
