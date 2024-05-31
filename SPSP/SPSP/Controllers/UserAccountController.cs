using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models;
using SPSP.Models.Request.UserAccount;
using SPSP.Models.SearchObjects;
using SPSP.Services;
using SPSP.Services.UserAccount;

namespace SPSP.Controllers
{
    [ApiController]
    [AllowAnonymous]
    public class UserAccountController
        : BaseCRUDController<UserAccount, UserAccountSearchObject, UserAccountCreateRequest, UserAccountUpdateRequest>
    {

        public UserAccountController(ILogger<BaseCRUDController<UserAccount, UserAccountSearchObject, UserAccountCreateRequest, UserAccountUpdateRequest>> logger,
            IUserAccountService service)
            : base(logger, service)
        {
 
        }


    }
}
