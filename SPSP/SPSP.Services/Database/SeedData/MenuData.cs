using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class MenuData
    {
        public static void SeedData(this EntityTypeBuilder<Menu> entity)
        {
            entity.HasData(
                new Menu
                {
                    Id = 1,
                    Name = "Glavni meni - Verzija 1",
                    QRCode = "",
                    Valid = true
                }
            );
        }
    }
}




