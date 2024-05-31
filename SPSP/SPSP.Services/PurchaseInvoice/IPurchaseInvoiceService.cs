using SPSP.Models.SearchObjects;
using System.Threading.Tasks;
using SPSP.Services.Base;
using SPSP.Models.Request.PurchaseInvoice;

namespace SPSP.Services.PurchaseInvoice
{
    public interface IPurchaseInvoiceService 
        : ICRUDService<Models.PurchaseInvoice, PurchaseInvoiceSearchObject, PurchaseInvoiceCreateRequest, Object>
    {
    }
}
