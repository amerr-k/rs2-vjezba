using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.Reservation
{
    public class ReservationUpdateRequest
    {
        public string? ContactInfo { get; set; }
        public string? SpecialRequest { get; set; }
    }
}
