using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models.Request.Auth;
using SPSP.Models.Request.Customer;
using SPSP.Models.SearchObjects;
using SPSP.Services;
using SPSP.Services.Customer;
using SPSP.Services.UserAccount;
using System.Security.Claims;

namespace SPSP.Controllers
{
    [ApiController]
    [AllowAnonymous]
    public class CustomerController
        : BaseCRUDController<Models.Customer, CustomerSearchObject, CustomerCreateRequest, CustomerUpdateRequest>
    {

        private readonly ICustomerService customerService;

        public CustomerController(ILogger<BaseCRUDController<Models.Customer, CustomerSearchObject, CustomerCreateRequest, CustomerUpdateRequest>> logger,
            ICustomerService service)
            : base(logger, service)
        {
            customerService = service;
        }

        [HttpGet("GetCustomerAccountInfo")]
        public Models.Customer GetCustomerAccountInfo()
        {
            return customerService.GetCustomerAccountInfo();

        }
    }
}
