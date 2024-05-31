using SPSP.Models.Request.OrderItem;
using SPSP.Models.Request.PurchaseInvoiceItem;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.PurchaseInvoiceItem
{
    public interface IPurchaseInvoiceItemService 
        : IService<Models.PurchaseInvoiceItem, BaseSearchObject>
    {
        public Task<List<Models.PurchaseInvoiceItem>> CreateMultiple(IEnumerable<PurchaseInvoiceItemCreateRequest> purchaseInvoiceItems, int purchaseInvoiceId);
    }
}
