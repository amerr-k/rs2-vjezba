using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class SaleInvoiceItemData
    {
        public static void SeedData(this EntityTypeBuilder<SaleInvoiceItem> entity)
        {
            entity.HasData(
                new SaleInvoiceItem
                {
                    Id = 1,
                    SaleInvoiceId = 1,
                    MenuItemId = 16,
                    Quantity = 2,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 2,
                    SaleInvoiceId = 1,
                    MenuItemId = 1,
                    Quantity = 2,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 3,
                    SaleInvoiceId = 2,
                    MenuItemId = 9,
                    Quantity = 2,
                    Price = 10,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 4,
                    SaleInvoiceId = 2,
                    MenuItemId = 15,
                    Quantity = 1,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 5,
                    SaleInvoiceId = 3,
                    MenuItemId = 8,
                    Quantity = 2,
                    Price = 6,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 6,
                    SaleInvoiceId = 3,
                    MenuItemId = 7,
                    Quantity = 7,
                    Price = 14,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 7,
                    SaleInvoiceId = 4,
                    MenuItemId = 16,
                    Quantity = 2,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 8,
                    SaleInvoiceId = 4,
                    MenuItemId = 1,
                    Quantity = 2,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 9,
                    SaleInvoiceId = 5,
                    MenuItemId = 9,
                    Quantity = 2,
                    Price = 10,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 10,
                    SaleInvoiceId = 5,
                    MenuItemId = 15,
                    Quantity = 1,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 11,
                    SaleInvoiceId = 6,
                    MenuItemId = 8,
                    Quantity = 2,
                    Price = 6,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 12,
                    SaleInvoiceId = 6,
                    MenuItemId = 7,
                    Quantity = 7,
                    Price = 14,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 13,
                    SaleInvoiceId = 7,
                    MenuItemId = 16,
                    Quantity = 2,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 14,
                    SaleInvoiceId = 7,
                    MenuItemId = 1,
                    Quantity = 2,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 15,
                    SaleInvoiceId = 8,
                    MenuItemId = 9,
                    Quantity = 2,
                    Price = 10,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 16,
                    SaleInvoiceId = 8,
                    MenuItemId = 15,
                    Quantity = 1,
                    Price = 5,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 17,
                    SaleInvoiceId = 9,
                    MenuItemId = 8,
                    Quantity = 2,
                    Price = 6,
                    Discount = 0,
                    Valid = true
                },
                new SaleInvoiceItem
                {
                    Id = 18,
                    SaleInvoiceId = 9,
                    MenuItemId = 7,
                    Quantity = 7,
                    Price = 14,
                    Discount = 0,
                    Valid = true
                }

            );
        }
    }
}




