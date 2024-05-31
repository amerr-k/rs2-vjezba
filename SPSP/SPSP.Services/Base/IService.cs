using SPSP.Models;
using System.Threading.Tasks;

namespace SPSP.Services.Base
{
    public interface IService<T, TSearch> 
        where TSearch : class
    {
        Task<PagedResult<T>> Get(TSearch search = null);
        Task<T> GetById(int id);
    }
}
