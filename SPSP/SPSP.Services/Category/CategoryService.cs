using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;

namespace SPSP.Services.Category
{
    public class CategoryService : BaseService<Models.Category, Database.Category, BaseSearchObject>, ICategoryService
    {
        public CategoryService(DataDbContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

    }

}

