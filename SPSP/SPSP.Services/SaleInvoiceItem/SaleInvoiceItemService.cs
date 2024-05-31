using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.SaleInvoiceItem;

namespace SPSP.Services.SaleInvoiceItem
{
    public class SaleInvoiceItemService : BaseService<Models.SaleInvoiceItem, Database.SaleInvoiceItem, BaseSearchObject>, ISaleInvoiceItemService
    {

        public SaleInvoiceItemService(DataDbContext context, IMapper mapper) 
            : base(context, mapper)
        {
           
        }

        public async Task<List<Models.SaleInvoiceItem>> CreateMultiple(IEnumerable<SaleInvoiceItemCreateRequest> saleInvoiceItems, int saleInvoiceId)
        {
            var saleInvoiceItemEntities = new List<Database.SaleInvoiceItem>();

            foreach (var item in saleInvoiceItems)
            {
                var saleInvoiceItemEntity = mapper.Map<Database.SaleInvoiceItem>(item);
                saleInvoiceItemEntity.SaleInvoiceId = saleInvoiceId;
                saleInvoiceItemEntities.Add(saleInvoiceItemEntity);
            }

            await context.SaleInvoiceItems.AddRangeAsync(saleInvoiceItemEntities);
            await context.SaveChangesAsync();
            return mapper.Map<List<Models.SaleInvoiceItem>>(saleInvoiceItemEntities);
        }
    }
}
