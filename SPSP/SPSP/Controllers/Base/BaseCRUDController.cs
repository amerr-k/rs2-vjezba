using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Models;
using SPSP.Models.Request.Order;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;
using SPSP.Services.Order;
using System.Threading.Tasks;

namespace SPSP.Controllers.Base
{
    [Route("[controller]")]
    [Authorize]
    public class BaseCRUDController<T, TSearch, TCreate, TUpdate> 
        : BaseController<T, TSearch> 
        where T : class where TSearch : class where TCreate : class where TUpdate : class
    {
        protected readonly ILogger<BaseCRUDController<T, TSearch, TCreate, TUpdate>> logger; //logger nam ovdje sad za sad ne treba, jer ga već ima u nasljedjenom BaseControlleru
        protected new readonly ICRUDService<T, TSearch, TCreate, TUpdate> service;

        public BaseCRUDController(ILogger<BaseCRUDController<T, TSearch, TCreate, TUpdate>> logger, ICRUDService<T, TSearch, TCreate, TUpdate> service)
            : base(logger, service)
        {
            this.service = service;
        }

        [HttpPost]
        public async Task<T> Create([FromBody]TCreate create)
        {
            return await service.Create(create);
        }

        [HttpPut("{id}")]
        public async Task<T> Update(int id, [FromBody] TUpdate update)
        {
            return await service.Update(id, update);
        }
    }
}
