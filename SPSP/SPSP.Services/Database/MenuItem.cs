using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class MenuItem
    {
        public MenuItem()
        {
            OrderItems = new HashSet<OrderItem>();
            PurchaseInvoiceItems = new HashSet<PurchaseInvoiceItem>();
            SaleInvoiceItems = new HashSet<SaleInvoiceItem>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public int MenuId { get; set; }
        public int? CategoryId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal? Price { get; set; }
        public bool? Valid { get; set; }
        public int InStorage { get; set; }
        public byte[]? Image { get; set; }
        public byte[]? ImageThumb { get; set; }
        public virtual Category Category { get; set; }
        public virtual Menu Menu { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
        public virtual ICollection<PurchaseInvoiceItem> PurchaseInvoiceItems { get; set; }
        public virtual ICollection<SaleInvoiceItem> SaleInvoiceItems { get; set; }
        public virtual ICollection<MenuItemPrediction> MainMenuItems { get; set; }
        public virtual ICollection<MenuItemPrediction> RecommendedMenuItems { get; set; }
        public virtual ICollection<Promotion> Promotions { get; set; }
    }
}
