using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Models;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SPSP.Services.Base
{
    public class BaseService<T, TDb, TSearch> 
        : IService<T, TSearch> 
        where TDb : class where T : class where TSearch : BaseSearchObject
    {
        protected readonly DataDbContext context;
        protected readonly IMapper mapper;

        public BaseService(DataDbContext context, IMapper mapper)
        {
            this.context = context;
            this.mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch search = null)
        {
            var query = context.Set<TDb>().AsQueryable();

            query = AddFilter(query, search);

            query = AddInclude(query, search);

            var result = new PagedResult<T>
            {
                Count = await query.CountAsync()
            };

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = mapper.Map<List<T>>(list);

            return result;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await context.Set<TDb>().FindAsync(id);

            return mapper.Map<T>(entity);
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

    }
}


//public Models.MenuItem Insert(MenuItemInsertRequest request)
//{
//    var entity = new Database.MenuItem();
//    mapper.Map(request, entity);

//    context.MenuItems.Add(entity);
//    context.SaveChanges();

//    return mapper.Map<Models.MenuItem>(entity);
//}