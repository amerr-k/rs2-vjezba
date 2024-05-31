using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SPSP.Services.Database.SeedData
{
    public static class UserAccountData
    {
        public static void SeedData(this EntityTypeBuilder<UserAccount> entity)
        {
            entity.HasData(
                new UserAccount
                {
                    Id = 1,
                    Username = "admin",
                    PasswordSalt = "sqnN7UwkaV8EqKiVngpHDA==",
                    PasswordHash = "cCq+zDvjCFgRlpQ7hp3aaLo14c0=",
                    Email = "admin@gmail.com",
                    FirstName = "Edina",
                    LastName = "Kovač",
                    Registered = true,
                    Valid = true
                },
                new UserAccount
                {
                    Id = 2,
                    Username = "radnik",
                    PasswordSalt = "sqnN7UwkaV8EqKiVngpHDA==",
                    PasswordHash = "cCq+zDvjCFgRlpQ7hp3aaLo14c0=",
                    Email = "radnik@gmail.com",
                    FirstName = "Mehmedalija",
                    LastName = "Kovač",
                    Registered = true,
                    Valid = true
                },
                new UserAccount
                {
                    Id = 3,
                    Username = "kupac",
                    PasswordSalt = "sqnN7UwkaV8EqKiVngpHDA==",
                    PasswordHash = "cCq+zDvjCFgRlpQ7hp3aaLo14c0=",
                    Email = "kupac@gmail.com",
                    FirstName = "Amer",
                    LastName = "Kovač",
                    Registered = true,
                    Valid = true
                },
                new UserAccount
                {
                    Id = 4,
                    Username = "kupac2",
                    PasswordSalt = "sqnN7UwkaV8EqKiVngpHDA==",
                    PasswordHash = "cCq+zDvjCFgRlpQ7hp3aaLo14c0=",
                    Email = "kupac2@gmail.com",
                    FirstName = "Ishak",
                    LastName = "Kovač",
                    Registered = true,
                    Valid = true
                },
                new UserAccount
                {
                    Id = 5,
                    Username = "kupac3",
                    PasswordSalt = "sqnN7UwkaV8EqKiVngpHDA==",
                    PasswordHash = "cCq+zDvjCFgRlpQ7hp3aaLo14c0=",
                    Email = "kupac3@gmail.com",
                    FirstName = "Himzo",
                    LastName = "Polovina",
                    Registered = true,
                    Valid = true
                }
            );
        }
    }
}




