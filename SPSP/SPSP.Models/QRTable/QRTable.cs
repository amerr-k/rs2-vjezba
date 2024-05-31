using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Models
{
    public partial class QRTable
    {
        public int Id { get; set; }
        public byte[] QRCode { get; set; }
        public int? TableNumber { get; set; }
        public int? Capacity { get; set; }

        public string LocationDescription { get; set; }
        public bool IsTaken { get; set; }
        public bool? IsReserved { get; set; }
        public bool? Valid { get; set; }
    }
}
