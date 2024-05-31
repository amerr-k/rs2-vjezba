using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class Employee
    {
        public Employee()
        {
            PurchaseInvoices = new HashSet<PurchaseInvoice>();
            SaleInvoices = new HashSet<SaleInvoice>();
        }

        public int Id { get; set; }
        public int UserAccountId { get; set; }
        public bool? Valid { get; set; }

        public virtual UserAccount UserAccount { get; set; }
        public virtual ICollection<PurchaseInvoice> PurchaseInvoices { get; set; }
        public virtual ICollection<SaleInvoice> SaleInvoices { get; set; }
    }
}
