using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models.Request.Employee;
using SPSP.Models.SearchObjects;
using SPSP.Services.Employee;

namespace SPSP.Controllers
{
    [ApiController] // mora ostati u konkretnom kontroleru zbog swaggera
    public class EmployeeController
        : BaseCRUDController<Models.Employee, EmployeeSearchObject, EmployeeCreateRequest, EmployeeUpdateRequest>
    {

        public EmployeeController(ILogger<BaseCRUDController<Models.Employee, EmployeeSearchObject, EmployeeCreateRequest, EmployeeUpdateRequest>> logger,
            IEmployeeService service)
            : base(logger, service)
        {
 
        }
    }
}
