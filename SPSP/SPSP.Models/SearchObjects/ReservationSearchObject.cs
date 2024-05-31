using SPSP.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.SearchObjects
{
    public class ReservationSearchObject : BaseSearchObject
    {
        public bool? IsQRTableIncluded { get; set; }
        public bool? SearchByCustomer { get; set; }
        public string? ReservationStatus { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? EndTime { get; set; }
    }
}
