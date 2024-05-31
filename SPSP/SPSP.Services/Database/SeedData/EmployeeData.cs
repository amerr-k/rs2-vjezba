using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.Extensions.Options;

namespace SPSP.Services.Database.SeedData
{
    public static class EmployeeData
    {
        public static void SeedData(this EntityTypeBuilder<Employee> entity)
        {
            entity.HasData(
                new Employee
                {
                    Id = 1,
                    UserAccountId = 1,
                    Valid = true
                },
                new Employee
                {
                    Id = 2,
                    UserAccountId = 2,
                    Valid = true
                }
            ); ;
        }
    }
}




