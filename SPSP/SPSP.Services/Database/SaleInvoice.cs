using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class SaleInvoice
    {
        public SaleInvoice()
        {
            SaleInvoiceItems = new HashSet<SaleInvoiceItem>();
        }

        public int Id { get; set; }
        public string InvoiceNumber { get; set; }
        public DateTime SaleDate { get; set; }
        public decimal? TotalAmount { get; set; }
        public decimal? TotalAmountWithVAT { get; set; }
        public decimal? VAT { get; set; }
        public decimal? VATAmount { get; set; }
        public int? EmployeeId { get; set; }
        public virtual Employee Employee { get; set; }
        public int? CustomerId { get; set; }
        public int OrderId { get; set; }
        public virtual Order Order { get; set; }
        public bool? Processed { get; set; }
        public bool? Valid { get; set; }
        public virtual ICollection<SaleInvoiceItem> SaleInvoiceItems { get; set; }
    }
}
