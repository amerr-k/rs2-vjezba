using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class PurchaseInvoiceItemData
    {
        public static void SeedData(this EntityTypeBuilder<PurchaseInvoiceItem> entity)
        {
            entity.HasData(
                new PurchaseInvoiceItem
                {
                    Id = 1,
                    PurchaseInvoiceId = 1,
                    MenuItemId = 1,
                    Quantity = 20,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 2,
                    PurchaseInvoiceId = 1,
                    MenuItemId = 2,
                    Quantity = 10,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 3,
                    PurchaseInvoiceId = 1,
                    MenuItemId = 3,
                    Quantity = 20,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 4,
                    PurchaseInvoiceId = 2,
                    MenuItemId = 4,
                    Quantity = 5,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 5,
                    PurchaseInvoiceId = 2,
                    MenuItemId = 5,
                    Quantity = 20,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 6,
                    PurchaseInvoiceId = 2,
                    MenuItemId = 6,
                    Quantity = 20,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 7,
                    PurchaseInvoiceId = 3,
                    MenuItemId = 7,
                    Quantity = 5,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 8,
                    PurchaseInvoiceId = 3,
                    MenuItemId = 8,
                    Quantity = 10,
                    UnitPrice = 2,
                    Valid = true
                },
                new PurchaseInvoiceItem
                {
                    Id = 9,
                    PurchaseInvoiceId = 3,
                    MenuItemId = 9,
                    Quantity = 15,
                    UnitPrice = 2,
                    Valid = true
                }
            );
        }
    }
}




