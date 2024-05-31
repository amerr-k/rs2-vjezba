using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.PaymentGatewayData
{
    public class PaymentGatewayDataCreateRequest
    {
        [Required]
        public bool Error { get; set; }
        [Required]
        public string Message { get; set; }
        [Required]
        public string Data { get; set; }
        
    }
}
