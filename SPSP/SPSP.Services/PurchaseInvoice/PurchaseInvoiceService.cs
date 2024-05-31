using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.PurchaseInvoice;
using SPSP.Models.SearchObjects;
using SPSP.Services.PurchaseInvoiceItem;

namespace SPSP.Services.PurchaseInvoice
{
    public class PurchaseInvoiceService
        : BaseCRUDService<Models.PurchaseInvoice, Database.PurchaseInvoice, PurchaseInvoiceSearchObject, PurchaseInvoiceCreateRequest, Object>, IPurchaseInvoiceService
    {
        protected readonly IPurchaseInvoiceItemService purchaseInvoiceItemService;

        public PurchaseInvoiceService(DataDbContext context, IMapper mapper, IPurchaseInvoiceItemService purchaseInvoiceItemService) 
            : base(context, mapper)
        {
            this.purchaseInvoiceItemService = purchaseInvoiceItemService;
        }

        public override IQueryable<Database.PurchaseInvoice> AddInclude(IQueryable<Database.PurchaseInvoice> query, PurchaseInvoiceSearchObject search = null)
        {
            if (search.IsPurchaseInvoiceItemsIncluded == true)
            {
                query = query.Include(x => x.PurchaseInvoiceItems) 
                            .ThenInclude(o => o.MenuItem)
                            .ThenInclude(c => c.Category);
            }

            return base.AddInclude(query, search);
        }

        public override async Task<Models.PurchaseInvoice> Create(PurchaseInvoiceCreateRequest create)
        {
            var PurchaseInvoiceEntity = mapper.Map<Database.PurchaseInvoice>(create);

            context.PurchaseInvoices.Add(PurchaseInvoiceEntity);
            await context.SaveChangesAsync();

            List<Models.PurchaseInvoiceItem> PurchaseInvoiceItems;
            var PurchaseInvoice = mapper.Map<Models.PurchaseInvoice>(PurchaseInvoiceEntity);
            
            if (create.PurchaseInvoiceItems  != null)
            {
                PurchaseInvoiceItems = await purchaseInvoiceItemService.CreateMultiple(create.PurchaseInvoiceItems, PurchaseInvoiceEntity.Id);
                PurchaseInvoice.PurchaseInvoiceItems = PurchaseInvoiceItems;
            }

            return PurchaseInvoice;
        }

        public override IQueryable<Database.PurchaseInvoice> AddFilter(IQueryable<Database.PurchaseInvoice> query, PurchaseInvoiceSearchObject search)
        {



            return base.AddFilter(query, search);
        }

    }
}
