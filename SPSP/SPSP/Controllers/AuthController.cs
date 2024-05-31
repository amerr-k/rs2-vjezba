using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SPSP.Models.Request.Auth;
using SPSP.Models.Request.Customer;
using SPSP.Models.Request.UserAccount;
using SPSP.Services.Customer;
using SPSP.Services.UserAccount;

namespace SPSP.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [AllowAnonymous]
    public class AuthController 
    {
        readonly IUserAccountService userAccountService;
        readonly ICustomerService customerService;

        readonly ILogger<AuthController> logger;

        public AuthController(ILogger<AuthController> logger, ICustomerService customerService, IUserAccountService userAccountService)
        {
            this.customerService = customerService;
            this.userAccountService = userAccountService;
        }

        [HttpPost("login")]
        public async Task<Models.UserAuthInfo> Login([FromBody] LoginRequest loginRequest)
        {
            return await userAccountService.Login(loginRequest.Username, loginRequest.Password);
        }

        [HttpPost("register")]
        public async Task<Models.UserAuthInfo> Register([FromBody] CustomerCreateRequest customerCreateRequest)
        {
            return await customerService.Register(customerCreateRequest);
        }

    }
}
