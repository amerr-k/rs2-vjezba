using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Models;
using SPSP.Services.Base;
using System.Threading.Tasks;

namespace SPSP.Controllers.Base
{
    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch> 
        : ControllerBase 
        where T : class where TSearch : class
    {
        protected readonly ILogger<BaseController<T, TSearch>> logger;
        protected readonly IService<T, TSearch> service;

        public BaseController(ILogger<BaseController<T, TSearch>> logger, IService<T, TSearch> service)
        {
            this.logger = logger;
            this.service = service;
        }

        [HttpGet]
        public async Task<PagedResult<T>> Get([FromQuery] TSearch search = null)
        {
            return await service.Get(search);
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await service.GetById(id);
        }
    }
}
