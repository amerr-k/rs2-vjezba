using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class OrderItemData
    {
        public static void SeedData(this EntityTypeBuilder<OrderItem> entity)
        {
            entity.HasData(
                new OrderItem
                {
                    Id = 1,
                    OrderId = 1,
                    MenuItemId = 16,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 2,
                    OrderId = 1,
                    MenuItemId = 1,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 3,
                    OrderId = 2,
                    MenuItemId = 9,
                    Quantity = 2,
                    Subtotal = 10,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 4,
                    OrderId = 2,
                    MenuItemId = 15,
                    Quantity = 1,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 5,
                    OrderId = 3,
                    MenuItemId = 8,
                    Quantity = 2,
                    Subtotal = 6,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 6,
                    OrderId = 3,
                    MenuItemId = 7,
                    Quantity = 7,
                    Subtotal = 14,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 7,
                    OrderId = 4,
                    MenuItemId = 16,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 8,
                    OrderId = 4,
                    MenuItemId = 1,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 9,
                    OrderId = 5,
                    MenuItemId = 9,
                    Quantity = 2,
                    Subtotal = 10,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 10,
                    OrderId = 5,
                    MenuItemId = 15,
                    Quantity = 1,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 11,
                    OrderId = 6,
                    MenuItemId = 8,
                    Quantity = 2,
                    Subtotal = 6,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 12,
                    OrderId = 6,
                    MenuItemId = 7,
                    Quantity = 7,
                    Subtotal = 14,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 13,
                    OrderId = 7,
                    MenuItemId = 16,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 14,
                    OrderId = 7,
                    MenuItemId = 1,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 15,
                    OrderId = 8,
                    MenuItemId = 9,
                    Quantity = 2,
                    Subtotal = 10,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 16,
                    OrderId = 8,
                    MenuItemId = 15,
                    Quantity = 1,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 17,
                    OrderId = 9,
                    MenuItemId = 8,
                    Quantity = 2,
                    Subtotal = 6,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 18,
                    OrderId = 9,
                    MenuItemId = 7,
                    Quantity = 7,
                    Subtotal = 14,
                    Valid = true
                },

                new OrderItem
                {
                    Id = 19,
                    OrderId = 10,
                    MenuItemId = 16,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 20,
                    OrderId = 10,
                    MenuItemId = 1,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 21,
                    OrderId = 11,
                    MenuItemId = 9,
                    Quantity = 2,
                    Subtotal = 10,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 22,
                    OrderId = 11,
                    MenuItemId = 15,
                    Quantity = 1,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 23,
                    OrderId = 12,
                    MenuItemId = 8,
                    Quantity = 2,
                    Subtotal = 6,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 24,
                    OrderId = 12,
                    MenuItemId = 7,
                    Quantity = 7,
                    Subtotal = 14,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 25,
                    OrderId = 13,
                    MenuItemId = 16,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 26,
                    OrderId = 13,
                    MenuItemId = 1,
                    Quantity = 2,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 27,
                    OrderId = 14,
                    MenuItemId = 9,
                    Quantity = 2,
                    Subtotal = 10,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 28,
                    OrderId = 14,
                    MenuItemId = 15,
                    Quantity = 1,
                    Subtotal = 5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 29,
                    OrderId = 15,
                    MenuItemId = 8,
                    Quantity = 2,
                    Subtotal = 6,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 30,
                    OrderId = 15,
                    MenuItemId = 7,
                    Quantity = 7,
                    Subtotal = 14,
                    Valid = true
                },
                //bitno za recommender: kola
                new OrderItem
                {
                    Id = 31,
                    OrderId = 16,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 32,
                    OrderId = 17,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 33,
                    OrderId = 17,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 34,
                    OrderId = 18,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 35,
                    OrderId = 18,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 36,
                    OrderId = 19,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 37,
                    OrderId = 19,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 38,
                    OrderId = 20,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 39,
                    OrderId = 20,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 40,
                    OrderId = 21,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 41,
                    OrderId = 21,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 42,
                    OrderId = 22,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 43,
                    OrderId = 22,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 44,
                    OrderId = 23,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 45,
                    OrderId = 23,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 46,
                    OrderId = 24,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 47,
                    OrderId = 24,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 48,
                    OrderId = 25,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 49,
                    OrderId = 25,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 50,
                    OrderId = 26,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 51,
                    OrderId = 26,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 52,
                    OrderId = 27,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 53,
                    OrderId = 27,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 54,
                    OrderId = 28,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 55,
                    OrderId = 28,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 56,
                    OrderId = 29,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 57,
                    OrderId = 29,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 58,
                    OrderId = 30,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 59,
                    OrderId = 30,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 60,
                    OrderId = 31,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 61,
                    OrderId = 31,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 62,
                    OrderId = 32,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 63,
                    OrderId = 32,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                },
                //kola i pomfrit:
                new OrderItem
                {
                    Id = 64,
                    OrderId = 33,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 65,
                    OrderId = 33,
                    MenuItemId = 8,
                    Quantity = 1,
                    Subtotal = 3,
                    Valid = true
                },
                //kola i vino
                new OrderItem
                {
                    Id = 66,
                    OrderId = 34,
                    MenuItemId = 1,
                    Quantity = 1,
                    Subtotal = (decimal)2.5,
                    Valid = true
                },
                new OrderItem
                {
                    Id = 67,
                    OrderId = 34,
                    MenuItemId = 18,
                    Quantity = 1,
                    Subtotal = (decimal)3.5,
                    Valid = true
                }
            );
        }
    }
}




