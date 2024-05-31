using SPSP.Models.Request.PurchaseInvoiceItem;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.PurchaseInvoice
{
    public class PurchaseInvoiceCreateRequest
    {
        public DateTime PurchaseDate { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal TotalAmountWithVAT { get; set; }
        public decimal? VAT { get; set; }
        public string? Note { get; set; }
        public bool Processed { get; set; }
        public int? EmployeeId { get; set; }
        public ICollection<PurchaseInvoiceItemCreateRequest>? PurchaseInvoiceItems { get; set; }
    }
}
