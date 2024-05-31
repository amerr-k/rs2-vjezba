using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class Customer
    {
        public Customer()
        {
            Orders = new HashSet<Order>();
            Reservations = new HashSet<Reservation>();
        }

        public int Id { get; set; }
        public int UserAccountId { get; set; }
        public int? PenaltyPoints { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public bool? Valid { get; set; }

        public virtual UserAccount UserAccount { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
    }
}
