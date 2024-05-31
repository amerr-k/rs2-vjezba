using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.SearchObjects
{
    public class PromotionSearchObject : BaseSearchObject
    {
        public bool? IsOnlyTodaysIncluded {  get; set; }
        public string? FTS { get; set; }

    }
}
