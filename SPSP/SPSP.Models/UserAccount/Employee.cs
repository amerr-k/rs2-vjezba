using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Models
{
    public partial class Employee
    {
        public int Id { get; set; }
        public int UserAccountId { get; set; }
        public bool IsAdmin { get; set; }
        public bool? Valid { get; set; }
        public virtual UserAccount UserAccount { get; set; }
    }
}
