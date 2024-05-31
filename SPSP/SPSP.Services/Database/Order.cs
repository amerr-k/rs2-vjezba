using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class Order
    {
        public Order()
        {
            OrderItems = new HashSet<OrderItem>();
            SaleInvoices = new HashSet<SaleInvoice>();
        }

        public int Id { get; set; }
        public int? CustomerId { get; set; }
        public DateTime OrderDateTime { get; set; }
        public decimal? TotalAmount { get; set; }
        public decimal TotalAmountWithVAT { get; set; }
        public decimal? VAT { get; set; }
        public decimal? VATAmount { get; set; }
        public string Status { get; set; }
        public int QRTableId { get; set; }
        public bool? Valid { get; set; }

        public virtual Customer Customer { get; set; }
        public virtual QRTable QRTable { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
        public virtual ICollection<SaleInvoice> SaleInvoices { get; set; }
    }
}
