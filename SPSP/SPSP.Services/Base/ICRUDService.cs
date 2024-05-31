using System.Threading.Tasks;

namespace SPSP.Services.Base
{
    public interface ICRUDService<T, TSearch, TCreate, TUpdate> 
        : IService<T, TSearch> 
        where TSearch : class 
        where TCreate : class 
        where TUpdate : class
    {
        Task<T> Create(TCreate create);
        Task<T> Update(int id, TUpdate update);
    }
}
