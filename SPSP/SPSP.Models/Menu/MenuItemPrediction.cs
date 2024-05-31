using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models
{
    public class MenuItemPrediction
    {
        public int Id { get; set; }
        public int MainMenuItemId { get; set; }
        public int RecommendedMenuItemId { get; set; }
        public virtual MenuItem RecommendedMenuItem { get; set; }
    }
}
