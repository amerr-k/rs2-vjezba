using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.Reservation
{
    public class ReservationCreateRequest
    {
        [Required]
        public int QRTableId { get; set; }
        public string? ContactInfo { get; set; }
        public string? SpecialRequest { get; set; }

        [DataType(DataType.DateTime)]
        public DateTime? StartTime { get; set; }

        [DataType(DataType.Date)]
        public DateTime? EndTime { get; set; }
    }
}
