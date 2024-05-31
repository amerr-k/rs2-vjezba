using SPSP.Models.Request.OrderItem;
using SPSP.Models.Request.SaleInvoiceItem;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.SaleInvoiceItem
{
    public interface ISaleInvoiceItemService 
        : IService<Models.SaleInvoiceItem, BaseSearchObject>
    {
        public Task<List<Models.SaleInvoiceItem>> CreateMultiple(IEnumerable<SaleInvoiceItemCreateRequest> saleInvoiceItems, int saleInvoiceId);
    }
}
