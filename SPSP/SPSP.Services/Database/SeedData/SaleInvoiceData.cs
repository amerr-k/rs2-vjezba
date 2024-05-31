using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class SaleInvoiceData
    {
        public static void SeedData(this EntityTypeBuilder<SaleInvoice> entity)
        {
            entity.HasData(
                new SaleInvoice
                {
                    Id = 1,
                    InvoiceNumber = "123456701",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    EmployeeId = 1,
                    CustomerId = 1,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 2,
                    InvoiceNumber = "123456702",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    EmployeeId = 1,
                    CustomerId = 2,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 3,
                    InvoiceNumber = "123456703",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    EmployeeId = 1,
                    CustomerId = 3,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 4,
                    InvoiceNumber = "123456704",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    EmployeeId = 1,
                    CustomerId = 1,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 5,
                    InvoiceNumber = "123456705",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    EmployeeId = 1,
                    CustomerId = 2,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 6,
                    InvoiceNumber = "123456706",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    EmployeeId = 1,
                    CustomerId = 3,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 7,
                    InvoiceNumber = "123456707",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    EmployeeId = 1,
                    CustomerId = 1,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 8,
                    InvoiceNumber = "123456708",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    EmployeeId = 1,
                    CustomerId = 2,
                    OrderId = 1,
                    Valid = true
                },
                new SaleInvoice
                {
                    Id = 9,
                    InvoiceNumber = "123456709",
                    SaleDate = DateTime.Now,
                    Processed = true,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    EmployeeId = 1,
                    CustomerId = 3,
                    OrderId = 1,
                    Valid = true
                }
            );
        }
    }
}




