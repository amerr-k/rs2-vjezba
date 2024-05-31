using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class UserAccountUserRoleData
    {
        public static void SeedData(this EntityTypeBuilder<UserAccountUserRole> entity)
        {
            entity.HasData(
                new UserAccountUserRole
                {
                    Id = 1,
                    UserAccountId = 1,
                    UserRoleId = 1,
                    Valid = true
                },
                new UserAccountUserRole
                {
                    Id = 2,
                    UserAccountId = 2,
                    UserRoleId = 1,
                    Valid = true
                }
            );
        }
    }
}




