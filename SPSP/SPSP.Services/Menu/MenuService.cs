using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using Microsoft.EntityFrameworkCore;

namespace SPSP.Services.Menu
{
    public class MenuService : BaseService<Models.Menu, Database.Menu, MenuSearchObject>, IMenuService
    {

        public MenuService(DataDbContext context, IMapper mapper) 
            : base(context, mapper)
        {
           
        }
        public override IQueryable<Database.Menu> AddInclude(IQueryable<Database.Menu> query, MenuSearchObject search = null)
        {
            if (search.IsMenuItemsIncluded == true)
            {
                query = query.Include(x => x.MenuItems);
            }

            return base.AddInclude(query, search);
        }

        //public override IQueryable<Database.MenuItem> AddFilter(IQueryable<Database.MenuItem> query, MenuItemSearchObject search)
        //{
        //    if (!string.IsNullOrWhiteSpace(search?.Name))
        //    {
        //        query = query.Where(x => x.Name.StartsWith(search.Name));
        //    }

        //    if (!string.IsNullOrWhiteSpace(search?.FTS))
        //    {
        //        query = query.Where(x => x.Name.Contains(search.FTS));
        //    }

        //    return base.AddFilter(query, search);
        //}

    }
}
