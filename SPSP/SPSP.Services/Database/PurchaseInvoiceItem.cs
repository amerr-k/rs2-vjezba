using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class PurchaseInvoiceItem
    {
        public int Id { get; set; }
        public int PurchaseInvoiceId { get; set; }
        public int MenuItemId { get; set; }
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal Subtotal { get; set; }
        public bool? Valid { get; set; }

        public virtual MenuItem MenuItem { get; set; }
        public virtual PurchaseInvoice PurchaseInvoice { get; set; }
    }
}
