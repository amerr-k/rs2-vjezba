using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class OrderData
    {
        public static void SeedData(this EntityTypeBuilder<Order> entity)
        {
            DateTime currentDate = DateTime.Today;

            // Specifično vrijeme danas (19:00)
            DateTime currentDayAt1900 = new DateTime(currentDate.Year, currentDate.Month, currentDate.Day, 19, 0, 0);

            // Yesterday's date
            DateTime yesterday = currentDate.AddDays(-1);

            entity.HasData(
                new Order
                {
                    Id = 1,
                    CustomerId = 1,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    Status = "COMPLETED",
                    QRTableId = 3,
                    Valid = true
                }
                ,
                new Order
                {
                    Id = 2,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    Status = "COMPLETED",
                    QRTableId = 4,
                    Valid = true
                }
                ,
                new Order
                {
                    Id = 3,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                }
                ,
                new Order
                {
                    Id = 4,
                    CustomerId = 1,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    Status = "COMPLETED",
                    QRTableId = 3,
                    Valid = true
                },
                new Order
                {
                    Id = 5,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    Status = "COMPLETED",
                    QRTableId = 4,
                    Valid = true
                },
                new Order
                {
                    Id = 6,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 7,
                    CustomerId = 1,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    Status = "COMPLETED",
                    QRTableId = 3,
                    Valid = true
                },
                new Order
                {
                    Id = 8,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    Status = "COMPLETED",
                    QRTableId = 4,
                    Valid = true
                },
                new Order
                {
                    Id = 9,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 10,
                    CustomerId = 1,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    Status = "ACTIVE",
                    QRTableId = 3,
                    Valid = true
                },
                new Order
                {
                    Id = 11,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    Status = "ACTIVE",
                    QRTableId = 4,
                    Valid = true
                },
                new Order
                {
                    Id = 12,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    Status = "ACTIVE",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 13,
                    CustomerId = 1,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)8.51,
                    TotalAmountWithVAT = 10,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)1.49,
                    Status = "CANCELED",
                    QRTableId = 3,
                    Valid = true
                },
                new Order
                {
                    Id = 14,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)12.82,
                    TotalAmountWithVAT = 15,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.18,
                    Status = "CANCELED",
                    QRTableId = 4,
                    Valid = true
                },
                new Order
                {
                    Id = 15,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)17.09,
                    TotalAmountWithVAT = 20,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)2.91,
                    Status = "CANCELED",
                    QRTableId = 5,
                    Valid = true
                },
                //bitno za recommender, 
                //zadnja kompletirana narudzba kupca, 
                //na osnovu zadnje kompletirane narudzbe, algoritam trazi preporuku
                //svi ostali kupci uz kolu, uzimaju pomfrit, crveno vino (bambus)
                new Order
                {
                    Id = 16,
                    CustomerId = 1,
                    OrderDateTime = DateTime.Now, 
                    TotalAmount = (decimal)2.1,
                    TotalAmountWithVAT = (decimal)2.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.4,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //sada kreću narudzbe koje u sebi imaju i kolu i neki drugi proizvod 
                //(pomfrit, vino)
                new Order
                {
                    Id = 17,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 18,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 19,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 20,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 21,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 22,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 23,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 24,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 25,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 26,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 27,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 28,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 29,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 30,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 31,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 32,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                //(pomfrit, vino)
                new Order
                {
                    Id = 33,
                    CustomerId = 2,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)4.7,
                    TotalAmountWithVAT = (decimal)5.5,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.8,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                },
                new Order
                {
                    Id = 34,
                    CustomerId = 3,
                    OrderDateTime = yesterday,
                    TotalAmount = (decimal)5.1,
                    TotalAmountWithVAT = (decimal)6,
                    VAT = (decimal)0.17,
                    VATAmount = (decimal)0.9,
                    Status = "COMPLETED",
                    QRTableId = 5,
                    Valid = true
                }
            );
        }
    }
}




