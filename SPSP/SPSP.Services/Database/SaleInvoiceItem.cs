using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class SaleInvoiceItem
    {
        public int Id { get; set; }
        public int SaleInvoiceId { get; set; }
        public int MenuItemId { get; set; }
        public int Quantity { get; set; }
        public decimal? Price { get; set; }
        public decimal? Discount { get; set; }
        public bool? Valid { get; set; }

        public virtual MenuItem MenuItem { get; set; }
        public virtual SaleInvoice SaleInvoice { get; set; }
    }
}
