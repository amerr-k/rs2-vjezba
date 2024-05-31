using System;
using System.Collections.Generic;

namespace SPSP.Models
{
    public partial class Category
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool? Valid { get; set; }
    }
}
