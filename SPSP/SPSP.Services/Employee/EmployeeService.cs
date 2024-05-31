using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.Employee;
using SPSP.Services.UserAccount;

namespace SPSP.Services.Employee
{

    public class EmployeeService : BaseCRUDService<Models.Employee, Database.Employee, EmployeeSearchObject, EmployeeCreateRequest, EmployeeUpdateRequest>, IEmployeeService
    {

        protected readonly IUserAccountService userAccountService;


        public EmployeeService(DataDbContext context, IMapper mapper, IUserAccountService userAccountService) 
            : base(context, mapper)
        {
            this.userAccountService = userAccountService;
            //obzirom da smo pozvali base() ne potrebno je ovdje dodavati i deklarisati context i mapper i funkcije
        }

        public override async Task<Models.Employee> Create(EmployeeCreateRequest create)
        {
            var customerEntity = mapper.Map<Database.Customer>(create);

            var userAccount = await userAccountService.Create(create);

            customerEntity.UserAccountId = userAccount.Id;

            context.Customers.Add(customerEntity);
            await context.SaveChangesAsync();

            return mapper.Map<Models.Employee>(customerEntity);
        }

        public override IQueryable<Database.Employee> AddInclude(IQueryable<Database.Employee> query, EmployeeSearchObject search = null)
        {
            if (search.IsUserAccountIncluded == true)
            {
                query = query.Include(x => x.UserAccount);
            }

            return base.AddInclude(query, search);
        }

    }
}
