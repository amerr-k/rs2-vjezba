using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class Menu
    {
        public Menu()
        {
            MenuItems = new HashSet<MenuItem>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string? QRCode { get; set; }
        public bool? IsActive { get; set; }
        public bool? Valid { get; set; }

        public virtual ICollection<MenuItem> MenuItems { get; set; }
    }
}
