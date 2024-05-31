using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.MenuItem;
using SPSP.Services.RecommenderService;

namespace SPSP.Services.MenuItem
{

    // dali menuitem service uopste treba naslijediti IMenuItemService, on vec nasljeduje IMenuItemService
    //prvo cu probat MenuItemService ovako pa cu onda zakomentarisats
    public class MenuItemService : BaseCRUDService<Models.MenuItem, Database.MenuItem, MenuItemSearchObject, MenuItemCreateRequest, MenuItemUpdateRequest>, IMenuItemService
    {
        //protected readonly IRecommenderService recommenderService;
        public MenuItemService(DataDbContext context, IMapper mapper, IRecommenderService recommenderService)
            : base(context, mapper)
        {
            //obzirom da smo pozvali base() ne potrebno je ovdje dodavati i deklarisati context i mapper i funkcije
            //this.recommenderService = recommenderService;
    }

        public override async Task PrepareBeforeCreate(Database.MenuItem entity, MenuItemCreateRequest insert)
        {
            //URADI NESTO SPECIFICNO ZA MENU ITEM SERVICE NPR DODAJ U ATRIBUT
        }

        public override async Task<Models.MenuItem> GetById(int id)
        {
            var entity = await context.Set<Database.MenuItem>()
                .Include(x => x.Category)
                .Include(x => x.Menu)
                .FirstOrDefaultAsync(x => x.Id == id);

            var model = mapper.Map<Models.MenuItem>(entity);

            return model;
        }

        public override IQueryable<Database.MenuItem> AddFilter(IQueryable<Database.MenuItem> query, MenuItemSearchObject search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Name))
            {
                query = query.Where(x => x.Name.StartsWith(search.Name));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(x => x.Name.Contains(search.FTS) || x.Code.Contains(search.FTS) || x.Description.Contains(search.FTS));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.MenuItem> AddInclude(IQueryable<Database.MenuItem> query, MenuItemSearchObject search = null)
        {
            if (search.IsCategoryIncluded == true)
            {
                query = query.Include(x => x.Category);
            }
            if (search.IsMenuIncluded == true)
            {
                query = query.Include(x => x.Menu);
            }

            return base.AddInclude(query, search);
        }
    }
}

