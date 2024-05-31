using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class ReservationData
    {
        public static void SeedData(this EntityTypeBuilder<Reservation> entity)
        {
            // Današnji dan
            DateTime currentDate = DateTime.Today;

            // Specifično vrijeme danas (19:00)
            DateTime curentDayAt1900 = new DateTime(currentDate.Year, currentDate.Month, currentDate.Day, 19, 0, 0);

            DateTime monthAfterAt1900 = new DateTime(currentDate.Year, currentDate.Month + 1, currentDate.Day, 19, 0, 0);
            DateTime twoMonthAfterAt1900 = new DateTime(currentDate.Year, currentDate.Month + 2, currentDate.Day, 19, 0, 0);

            entity.HasData(
                new Reservation
                {
                    Id = 1,
                    QRTableId = 1,
                    CustomerId = 1,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = DateTime.ParseExact("29.03.2024 19:00", "dd.MM.yyyy HH:mm", null),
                    EndTime = DateTime.ParseExact("29.03.2024 22:00", "dd.MM.yyyy HH:mm", null),
                    Status = "CANCELED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 2,
                    QRTableId = 2,
                    CustomerId = 2,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = DateTime.ParseExact("29.03.2024 19:00", "dd.MM.yyyy HH:mm", null),
                    EndTime = DateTime.ParseExact("29.03.2024 22:00", "dd.MM.yyyy HH:mm", null),
                    Status = "CANCELED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 3,
                    QRTableId = 3,
                    CustomerId = 3,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = DateTime.ParseExact("29.03.2024 19:00", "dd.MM.yyyy HH:mm", null),
                    EndTime = DateTime.ParseExact("29.03.2024 22:00", "dd.MM.yyyy HH:mm", null),
                    Status = "CANCELED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 4,
                    QRTableId = 4,
                    CustomerId = 1,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = curentDayAt1900,
                    EndTime = curentDayAt1900.AddHours(2),
                    Status = "CONFIRMED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 5,
                    QRTableId = 5,
                    CustomerId = 2,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = curentDayAt1900,
                    EndTime = curentDayAt1900.AddHours(2),
                    Status = "CONFIRMED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 6,
                    QRTableId = 1,
                    CustomerId = 3,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = curentDayAt1900,
                    EndTime = curentDayAt1900.AddHours(2),
                    Status = "CONFIRMED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 7,
                    QRTableId = 2,
                    CustomerId = 1,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = monthAfterAt1900,
                    EndTime = monthAfterAt1900.AddHours(2),
                    Status = "CONFIRMED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 8,
                    QRTableId = 3,
                    CustomerId = 2,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = monthAfterAt1900,
                    EndTime = monthAfterAt1900.AddHours(2),
                    Status = "CONFIRMED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 9,
                    QRTableId = 4,
                    CustomerId = 3,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = monthAfterAt1900,
                    EndTime = monthAfterAt1900.AddHours(2),
                    Status = "CONFIRMED",
                    Valid = true
                },
                new Reservation
                {
                    Id = 10,
                    QRTableId = 5,
                    CustomerId = 1,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = twoMonthAfterAt1900.AddDays(2),
                    EndTime = twoMonthAfterAt1900.AddDays(2).AddHours(2),
                    Status = "PENDING_CONFIRMATION",
                    Valid = true
                },
                new Reservation
                {
                    Id = 11,
                    QRTableId = 1,
                    CustomerId = 2,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = twoMonthAfterAt1900.AddDays(2),
                    EndTime = twoMonthAfterAt1900.AddDays(2).AddHours(2),
                    Status = "PENDING_CONFIRMATION",
                    Valid = true
                },
                new Reservation
                {
                    Id = 12,
                    QRTableId = 2,
                    CustomerId = 3,
                    ContactInfo = "123 123 123",
                    SpecialRequest = "Ništa posebno, samo nek je čisto",
                    StartTime = twoMonthAfterAt1900.AddDays(2),
                    EndTime = twoMonthAfterAt1900.AddDays(2).AddHours(2),
                    Status = "PENDING_CONFIRMATION",
                    Valid = true
                }
            );
        }
    }
}




