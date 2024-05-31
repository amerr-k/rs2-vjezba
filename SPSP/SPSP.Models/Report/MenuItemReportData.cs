using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models
{
    public class MenuItemReportData
    {
        public string Name { get; set; }    
        public string Category { get; set; }
        public decimal Price { get; set; }
        public int OrderCount { get; set; }
        public decimal TotalAmount { get; set; }    
    }
}
