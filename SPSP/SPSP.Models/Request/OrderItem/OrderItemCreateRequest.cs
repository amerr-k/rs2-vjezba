using SPSP.Models;
using SPSP.Models.Request.QRTable;
using System;
using System.ComponentModel.DataAnnotations;

namespace SPSP.Models.Request.OrderItem
{
    public class OrderItemCreateRequest
    {
        [Required]
        public int MenuItemId { get; set; }
        [Required]
        public int Quantity { get; set; }
        public decimal? Subtotal { get; set; }

    }
}