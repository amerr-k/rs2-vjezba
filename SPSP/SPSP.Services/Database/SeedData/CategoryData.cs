using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class CategoryData
    {
        public static void SeedData(this EntityTypeBuilder<Category> entity)
        {
            entity.HasData(
                new Category
                {
                    Id = 1,
                    Code = "BEZALKOHOLNA_PICA",
                    Name = "Bezalkoholna pića",
                    Valid = true
                },
                new Category
                {
                    Id = 2,
                    Code = "ALKOHOLNA_PICA",
                    Name = "Alkoholna pića",
                    Valid = true
                },
                new Category
                {
                    Id = 3,
                    Code = "GAZIRANI_SOKOVI",
                    Name = "Gazirani sokovi",
                    Valid = true
                },
                new Category
                {
                    Id = 4,
                    Code = "PRIRODNI_SOKOVI",
                    Name = "Prirodni sokovi",
                    Valid = true
                },
                new Category
                {
                    Id = 5,
                    Code = "KOKTELI",
                    Name = "Kokteli",
                    Valid = true
                },
                new Category
                {
                    Id = 6,
                    Code = "PIVO",
                    Name = "Pivo",
                    Valid = true
                },
                new Category
                {
                    Id = 7,
                    Code = "VINA",
                    Name = "Vina",
                    Valid = true
                },
                new Category
                {
                    Id = 8,
                    Code = "JELA_PO_NARUDZBI",
                    Name = "Jela po narudžbi",
                    Valid = true
                },
                new Category
                {
                    Id = 9,
                    Code = "OSTALO",
                    Name = "Ostalo",
                    Valid = true
                }
            );
        }
    }
}




