using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Services.Database
{
    public class PaymentGatewayData
    {
        public int Id { get; set; }
        public string Error { get; set; }
        public string Message { get; set; }
        public string Data { get; set; } 
        public bool? Valid { get; set; }
        public virtual ICollection<PurchaseInvoice> PurchaseInvoices { get; set; }
    }
}
