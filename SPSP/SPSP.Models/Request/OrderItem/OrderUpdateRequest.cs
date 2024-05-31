using SPSP.Models;
using System;
using System.ComponentModel.DataAnnotations;

namespace SPSP.Models.Request.OrderItem
{
    public class OrderItemUpdateRequest
    {
        [Required]
        public int MenuItemId { get; set; }
        [Required]
        public int Quantity { get; set; }
        public decimal? Subtotal { get; set; }
        public bool? Valid { get; set; }

    }
}