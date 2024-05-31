using SPSP.Models.Request.Reservation;
using SPSP.Models.Request.UserAccount;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.Employee
{
    public class EmployeeUpdateRequest
    {
        public UserAccountUpdateRequest UserAccount { get; set; }
    }
}
