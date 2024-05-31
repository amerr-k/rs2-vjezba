using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.PurchaseInvoiceItem;

namespace SPSP.Services.PurchaseInvoiceItem
{
    public class PurchaseInvoiceItemService : BaseService<Models.PurchaseInvoiceItem, Database.PurchaseInvoiceItem, BaseSearchObject>, IPurchaseInvoiceItemService
    {

        public PurchaseInvoiceItemService(DataDbContext context, IMapper mapper) 
            : base(context, mapper)
        {
           
        }

        public async Task<List<Models.PurchaseInvoiceItem>> CreateMultiple(IEnumerable<PurchaseInvoiceItemCreateRequest> purchaseInvoiceItems, int purchaseInvoiceId)
        {
            var purchaseInvoiceItemEntities = new List<Database.PurchaseInvoiceItem>();

            foreach (var item in purchaseInvoiceItems)
            {
                var purchaseInvoiceItemEntity = mapper.Map<Database.PurchaseInvoiceItem>(item);
                purchaseInvoiceItemEntity.PurchaseInvoiceId = purchaseInvoiceId;
                purchaseInvoiceItemEntities.Add(purchaseInvoiceItemEntity);
            }

            context.PurchaseInvoiceItems.AddRange(purchaseInvoiceItemEntities);
            await context.SaveChangesAsync();
            return mapper.Map<List<Models.PurchaseInvoiceItem>>(purchaseInvoiceItemEntities);
        }
    }
}
