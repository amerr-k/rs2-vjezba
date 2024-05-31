using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class UserRoleData
    {
        public static void SeedData(this EntityTypeBuilder<UserRole> entity)
        {
            entity.HasData(
                new UserRole
                {
                    Id = 1,
                    Code = "ADMIN",
                    Name = "Admin",
                    Valid = true
                }
            );
        }
    }
}




