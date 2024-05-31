using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.Customer;
using SPSP.Services.UserAccount;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using SPSP.Models;
using SPSP.Models.Request.UserAccount;

namespace SPSP.Services.Customer
{

    public class CustomerService : BaseCRUDService<Models.Customer, Database.Customer, CustomerSearchObject, CustomerCreateRequest, CustomerUpdateRequest>, ICustomerService
    {

        protected readonly IUserAccountService userAccountService;
        protected readonly IHttpContextAccessor httpContextAccessor;

        public CustomerService(DataDbContext context, IMapper mapper, IUserAccountService userAccountService, IHttpContextAccessor httpContextAccessor)
            : base(context, mapper)
        {
            this.userAccountService = userAccountService;
            this.httpContextAccessor = httpContextAccessor;
        }
        public override async Task<Models.Customer> Create(CustomerCreateRequest create)
        {
            var customerEntity = mapper.Map<Database.Customer>(create);

            var userAccount = await userAccountService.Create(create);

            customerEntity.UserAccountId = userAccount.Id;

            context.Customers.Add(customerEntity);
            await context.SaveChangesAsync();

            return mapper.Map<Models.Customer>(customerEntity);
        }

        public override async Task<Models.Customer> Update(int id, CustomerUpdateRequest update)
        {
            var customerEntity = mapper.Map<Database.Customer>(update);

            await userAccountService.Update(update.UserAccountId, update);

            context.Customers.Add(customerEntity);
            await context.SaveChangesAsync();

            return mapper.Map<Models.Customer>(customerEntity);
        }

        public override IQueryable<Database.Customer> AddInclude(IQueryable<Database.Customer> query, CustomerSearchObject search = null)
        {
            if (search.IsUserAccountIncluded == true)
            {
                query = query.Include(x => x.UserAccount);
            }

            return base.AddInclude(query, search);
        }

        public Models.Customer GetCustomerAccountInfo()
        {
            var principal = httpContextAccessor.HttpContext?.User;
            var userId = principal?.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            var customer = context.Customers
                .Include(x => x.UserAccount)
                .Where(x => x.UserAccountId == int.Parse(userId!))
                .FirstOrDefault();

            return mapper.Map<Models.Customer>(customer);
        }

        public async Task<UserAuthInfo> Register(CustomerCreateRequest customerCreateRequest)
        {
            var userAccount = await userAccountService.Create(customerCreateRequest);

            var customer = new Database.Customer { UserAccountId = userAccount.Id };

            context.Customers.Add(customer);
            await context.SaveChangesAsync();

            return new UserAuthInfo(userAccount, "");
        }
    }
}
