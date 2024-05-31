using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using SPSP.Services.Database;
using SPSP.Services.OrderEmailPublisher;
using SPSP.Services.SaleInvoice;
using SPSP.Services.SaleInvoiceItem;

namespace SPSP.Controllers
{

    [ApiController]

    public class TestController : Controller
    {
        IEmailPublisherService emailPublisherService;
        ISaleInvoiceService saleInvoiceService;
        IMapper mapper;
        DataDbContext context;

        public TestController(IEmailPublisherService emailPublisherService, ISaleInvoiceService saleInvoiceService, IMapper mapper, DataDbContext context) {
            this.emailPublisherService = emailPublisherService;
            this.saleInvoiceService = saleInvoiceService;
            this.mapper = mapper;
            this.context = context;
        }
        [HttpGet("Test")]

        public async Task<bool> Index()
        {
            var emailMessage = new Models.EmailMessage { Body = "TEST", Subject = "SUBJET TEST" };

            emailPublisherService.PublishSaleInvoiceEmail(emailMessage);
            return true;
        }
    }
}
