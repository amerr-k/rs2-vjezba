using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Models
{
    public partial class OrderItem
    {
        public int Id { get; set; }
        public int? OrderId { get; set; }
        public int? MenuItemId { get; set; }
        public int? Quantity { get; set; }
        public decimal? Subtotal { get; set; }
        public bool? Valid { get; set; }
        public virtual MenuItem MenuItem { get; set; }
    }
}
