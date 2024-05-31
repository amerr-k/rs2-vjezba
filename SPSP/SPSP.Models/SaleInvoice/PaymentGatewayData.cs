using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models
{
    public class PaymentGatewayData
    {
        public int Id { get; set; }
        public bool Error { get; set; }
        public string Message { get; set; }
        public string Data { get; set; }
    }
}
