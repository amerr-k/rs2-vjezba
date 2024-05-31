#nullable disable

namespace SPSP.Models
{
    public partial class SaleInvoice
    {
        public DateTime SaleDate { get; set; }
        
        public decimal? TotalAmount { get; set; }
        public decimal? TotalAmountWithVAT { get; set; }
        public decimal? VAT { get; set; }
        public decimal? VATAmount { get; set; }
        public int EmployeeId { get; set; }
        public int? CustomerId { get; set; }
        public int OrderId { get; set; }
        public bool? Valid { get; set; }
        public bool? Processed { get; set; }

        public virtual Employee Employee { get; set; }
        public virtual Order Order { get; set; }
        public virtual ICollection<SaleInvoiceItem> SaleInvoiceItems { get; set; }


        public int? PaymentGatewayDataId { get; set; }
        public virtual PaymentGatewayData? PaymentGatewayData {  get; set; }

    }
}
