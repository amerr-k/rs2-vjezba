using SPSP.Models.SearchObjects;
using System.Threading.Tasks;
using SPSP.Services.Base;
using SPSP.Models.Request.SaleInvoice;

namespace SPSP.Services.SaleInvoice
{
    public interface ISaleInvoiceService 
        : ICRUDService<Models.SaleInvoice, SaleInvoiceSearchObject, SaleInvoiceCreateRequest, Object>
    {
    }
}
