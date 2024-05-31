using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Models
{
    public partial class Order
    {
        public int Id { get; set; }
        public int? CustomerId { get; set; }
        public int? EmployeeId { get; set; }
        public int QRTableId { get; set; }
        public DateTime OrderDateTime { get; set; }
        public decimal? TotalAmount { get; set; }
        public decimal? TotalAmountWithVAT { get; set; }
        public decimal? VAT { get; set; }
        public decimal? VATAmount { get; set; }
        public string Status { get; set; }
        public bool? Valid { get; set; }
        public virtual Customer Customer { get; set; }
        public virtual Employee Employee { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
        public virtual QRTable QRTable { get; set; }

    }
}
