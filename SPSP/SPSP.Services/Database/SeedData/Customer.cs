using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class CustomerData
    {
        public static void SeedData(this EntityTypeBuilder<Customer> entity)
        {
            entity.HasData(
                new Customer
                {
                    Id = 1,
                    UserAccountId = 3,
                    PenaltyPoints = 0,
                    Address = "ul. Meše Selimovića",
                    Phone = "012 0123 01235"
                },
                new Customer
                {
                    Id = 2,
                    UserAccountId = 4,
                    PenaltyPoints = 0,
                    Address = "ul Jovana Dučića",
                    Phone = "012 0123 01236"
                },
                new Customer
                {
                    Id = 3,
                    UserAccountId = 5,
                    PenaltyPoints = 0,
                    Address = "ul žrtava Bube Correlija",
                    Phone = "012 0123 01236"
                }
            );
        }
    }
}




