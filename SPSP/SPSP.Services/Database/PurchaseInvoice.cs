using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class PurchaseInvoice
    {
        public PurchaseInvoice()
        {
            PurchaseInvoiceItems = new HashSet<PurchaseInvoiceItem>();
        }

        public int Id { get; set; }
        public string InvoiceNumber { get; set; }
        public DateTime PurchaseDate { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal TotalAmountWithVAT { get; set; }
        public decimal? VAT { get; set; }
        public string Note { get; set; }

        public bool? Valid { get; set; }
        public int? PaymentGatewayDataId { get; set; }
        public virtual PaymentGatewayData? PaymentGatewayData {  get; set; }
        public int? EmployeeId { get; set; }
        public virtual Employee? Employee { get; set; }
        public virtual ICollection<PurchaseInvoiceItem> PurchaseInvoiceItems { get; set; }
    }
}
