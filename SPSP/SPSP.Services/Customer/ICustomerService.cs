using SPSP.Models;
using SPSP.Models.Request.Customer;
using SPSP.Models.Request.UserAccount;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.Customer
{
    public interface ICustomerService 
        : ICRUDService<Models.Customer, CustomerSearchObject, CustomerCreateRequest, CustomerUpdateRequest>
    {
        public Models.Customer GetCustomerAccountInfo();
        Task<UserAuthInfo> Register(CustomerCreateRequest customerCreateRequest);
    }
}
