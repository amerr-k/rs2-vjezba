using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class PurchaseInvoiceData
    {
        public static void SeedData(this EntityTypeBuilder<PurchaseInvoice> entity)
        {
            entity.HasData(
                new PurchaseInvoice
                {
                    Id = 1,
                    InvoiceNumber = "123456780",
                    PurchaseDate = DateTime.ParseExact("21.02.2023 10:40", "dd.MM.yyyy HH:mm", null),
                    TotalAmount = 83,
                    TotalAmountWithVAT = 100,
                    VAT = (decimal?)0.17,
                    Note = "Dostava stigla na vrijeme",
                    EmployeeId = 1,
                    Valid = true
                },
                new PurchaseInvoice
                {
                    Id = 2,
                    InvoiceNumber = "123456781",
                    PurchaseDate = DateTime.ParseExact("23.03.2023 12:50", "dd.MM.yyyy HH:mm", null),
                    TotalAmount = (decimal)74.7,
                    TotalAmountWithVAT = 90,
                    VAT = (decimal?)0.17,
                    Note = "Dostava stigla na vrijeme",
                    EmployeeId = 1,
                    Valid = true
                },
                new PurchaseInvoice
                {
                    Id = 3,
                    InvoiceNumber = "123456782",
                    PurchaseDate = DateTime.ParseExact("24.04.2023 11:30", "dd.MM.yyyy HH:mm", null),
                    TotalAmount = (decimal)41.5,
                    TotalAmountWithVAT = 50,
                    VAT = (decimal?)0.17,
                    Note = "Dostava kasnila",
                    EmployeeId = 2,
                    Valid = true
                }
            );
        }
    }
}




