using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.SaleInvoiceItem
{
    public class SaleInvoiceItemCreateRequest
    {
        [Required]
        public int MenuItemId { get; set; }
        [Required]
        public int Quantity { get; set; }
        public decimal? Subtotal { get; set; }
        public decimal? UnitPrice { get; set; }
    }
}
