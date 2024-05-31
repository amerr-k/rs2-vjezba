using SPSP.Models;
using System;
using System.ComponentModel.DataAnnotations;

namespace SPSP.Models.Request.Order
{
    public class OrderUpdateRequest
    {

        public int? CustomerId { get; set; }
        public int? EmployeeId { get; set; }
        public decimal? TotalAmountWithVAT { get; set; }
        public decimal? VAT { get; set; }
        [Required]
        public int QRTableId { get; set; }

    }
}