using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Models
{
    public partial class Customer
    {

        public int Id { get; set; }
        public int? UserAccountId { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public int? PenaltyPoints { get; set; }
        public bool? Valid { get; set; }
        public virtual UserAccount UserAccount { get; set; }

    }
}
