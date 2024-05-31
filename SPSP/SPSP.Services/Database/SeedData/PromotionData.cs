using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class PromotionData
    {
        public static void SeedData(this EntityTypeBuilder<Promotion> entity)
        {
            entity.HasData(
                new Promotion
                {
                    Id = 1,
                    StartTime = DateTime.Now,
                    Description = "Predstavljamo Vam naš novi proizvod.",
                    Active = true,
                    MenuItemId = 6,
                    Valid = true
                }
            );
        }
    }
}




