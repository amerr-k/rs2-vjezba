using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class QRTable
    {
        public QRTable()
        {
            Orders = new HashSet<Order>();
            Reservations = new HashSet<Reservation>();
        }

        public int Id { get; set; }
        public byte[]? QRCode { get; set; }
        public int? TableNumber { get; set; }
        public int? Capacity { get; set; }
        public string LocationDescription { get; set; }
        public bool IsTaken { get; set; }
        public bool? Valid { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
    }
}
