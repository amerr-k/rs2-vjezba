using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class Reservation
    {
        public int Id { get; set; }
        public int QRTableId { get; set; }
        public int CustomerId { get; set; }
        public string ContactInfo { get; set; }
        public string SpecialRequest { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public string Status { get; set; }
        public bool? Valid { get; set; }

        public virtual Customer Customer { get; set; }
        public virtual QRTable QRTable { get; set; }
    }
}
