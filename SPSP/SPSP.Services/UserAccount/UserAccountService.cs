using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.UserAccount;
using System.Security.Cryptography;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using SPSP.Models;

namespace SPSP.Services.UserAccount
{

    public class UserAccountService : BaseCRUDService<Models.UserAccount, Database.UserAccount, UserAccountSearchObject, UserAccountCreateRequest, UserAccountUpdateRequest>, IUserAccountService
    {

        public UserAccountService(DataDbContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override async Task PrepareBeforeCreate(Database.UserAccount entity, UserAccountCreateRequest create)
        {
            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, create.Password);
        }

        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }


        public override IQueryable<Database.UserAccount> AddInclude(IQueryable<Database.UserAccount> query, UserAccountSearchObject? search = null)
        {
            if (search?.IsUserRolesIncluded == true)
            {
                query = query.Include("UserAccountUserRoles.UserRole");
            }
            return base.AddInclude(query, search);
        }
        public async Task<Models.UserAccount> GetAuthenticatedUserAccount(string username, string password)
        {
            var entity = await context.UserAccounts.Include("UserAccountUserRoles.UserRole").FirstOrDefaultAsync(x => x.Username == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.PasswordSalt, password);

            if (hash != entity.PasswordHash)
            {
                return null;
            }

            return mapper.Map<Models.UserAccount>(entity);
        }

        public async Task<Models.UserAuthInfo> Login(string username, string password)
        {
            //SHOULD RETURN TOKEN AFTER LOGIN

            var userAccount = await GetAuthenticatedUserAccount(username, password);

            if(userAccount == null)
            {
                throw new AppException("Unijeli ste pogrešne kredencijale.");
            }

            var jwtToken = GenerateJwtToken(userAccount);

            return new UserAuthInfo(userAccount, jwtToken);
        }

        public string GenerateJwtToken(Models.UserAccount userAccount)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.Name, userAccount.Username),
                new Claim(ClaimTypes.Email, userAccount.Email),
                new Claim(ClaimTypes.NameIdentifier, userAccount.Id.ToString()),
             };

            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("mojkljucstavigauappsettingsmojkljucstavigauappsettings"));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: "spspIssuer",
                audience: "spspAudience",
                claims: claims,
                expires: DateTime.UtcNow.AddDays(7),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public async Task<UserAuthInfo> Register(UserAccountCreateRequest userAccountCreateRequest)
        {
            var userAccount = await Create(userAccountCreateRequest);

            //context.Customers.Add(new Database.Customer
            //{
            //    UserAccountId = userAccount.Id
            //});

            //await context.SaveChangesAsync();

            return new UserAuthInfo(userAccount, "");
        }


    }
}
