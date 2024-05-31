using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using System.Threading.Tasks;

namespace SPSP.Services.Base
{
    public class BaseCRUDService<T, TDb, TSearch, TCreate, TUpdate> 
        : BaseService<T, TDb, TSearch> 
        where TDb : class where T : class 
        where TSearch : BaseSearchObject
    {

        public BaseCRUDService(DataDbContext context, IMapper mapper)
           : base(context, mapper)
        {

        }

        public virtual async Task PrepareBeforeCreate(TDb db, TCreate create)
        {
            
        }

        public virtual async Task<T> Create(TCreate create)
        {

            var set = context.Set<TDb>();

            var entity = mapper.Map<TDb>(create);

            set.Add(entity);

            await PrepareBeforeCreate(entity, create);

            await context.SaveChangesAsync();

            return mapper.Map<T>(entity);
        }

        public virtual async Task<T> Update(int id, TUpdate update)
        {

            var set = context.Set<TDb>();

            var entity = await set.FindAsync(id);

            mapper.Map(update, entity);

            await context.SaveChangesAsync();

            return mapper.Map<T>(entity);
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