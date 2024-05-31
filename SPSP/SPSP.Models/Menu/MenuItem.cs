using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Models
{
    public partial class MenuItem
    {
        public int Id { get; set; }
        public int MenuId { get; set; }
        public int? CategoryId { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal? Price { get; set; }
        public bool? Valid { get; set; }
        public int InStorage { get; set; }
        public byte[] Image { get; set; }
        public byte[] ImageThumb { get; set; }
        public virtual Category Category { get; set; }
        public virtual Menu Menu { get; set; }

    }
}
