using AutoMapper;
using Microsoft.AspNetCore.Http;
using SPSP.Models.Request.Reservation;
using SPSP.Services.Customer;
using SPSP.Services.Database;
using SPSP.Services.Reservation.StateMachine.Generics;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;

namespace SPSP.Services.Reservation.StateMachine
{
    public class InitialReservationState
        : BaseState
    {

        private readonly IHttpContextAccessor httpContextAccessor;
        private readonly ICustomerService customerService;

        public InitialReservationState(IServiceProvider serviceProvider, DataDbContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor, ICustomerService customerService)
            : base(serviceProvider, context, mapper)
        {
            this.httpContextAccessor = httpContextAccessor;
            this.customerService = customerService;
        }

        public override async Task<Models.Reservation> Create(ReservationCreateRequest create)
        {
            var customer = customerService.GetCustomerAccountInfo();
            
            var set = context.Set<Database.Reservation>();

            var entity = mapper.Map<Database.Reservation>(create);
            entity.Status = "PENDING_CONFIRMATION";
            entity.CustomerId = customer.Id;


            set.Add(entity);

            await context.SaveChangesAsync();

            return mapper.Map<Models.Reservation>(entity);
        }

        public override async Task<List<string>> GetAllowedActions()
        {
            var allowedActions = await base.GetAllowedActions();
            allowedActions.AddRange(new List<string> { "create" });
            return allowedActions;
        }
    }
}
