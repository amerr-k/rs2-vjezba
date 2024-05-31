using SPSP.Models.Request.Reservation;
using SPSP.Models.Request.UserAccount;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.Customer
{
    public class CustomerCreateRequest : UserAccountCreateRequest
    {
        public string? Address { get; set; }
        public string? Phone { get; set; }
    }
}
