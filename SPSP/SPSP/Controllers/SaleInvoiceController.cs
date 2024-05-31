using Microsoft.AspNetCore.Mvc;
using SPSP.Controllers.Base;
using SPSP.Models.Request.SaleInvoice;
using SPSP.Models.SearchObjects;
using SPSP.Services.SaleInvoice;

namespace SPSP.Controllers
{
    [ApiController]

    public class SaleInvoiceController : BaseCRUDController<Models.SaleInvoice, SaleInvoiceSearchObject, SaleInvoiceCreateRequest, Object>
    {
        public SaleInvoiceController(ILogger<BaseCRUDController<Models.SaleInvoice, SaleInvoiceSearchObject, SaleInvoiceCreateRequest, Object>> logger, ISaleInvoiceService service)
            : base(logger, service)
        {

        }
    }
}


//[HttpPost]
//public async Task<Models.SaleInvoice> Insert()
//{
//    return await (service as ISaleInvoiceService).Insert(); 
//bolje je da ako ce se ovaj servis koristit umjesto casta kreirati properti service na nivou ovog kontrolera
//}

//[HttpPost]
//public async Task<Models.SaleInvoice> Insert()
//{
//    return await service.Insert();
//    
//}