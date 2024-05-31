using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request.Reservation;
using System.Threading.Tasks;
using SPSP.Services.Reservation.StateMachine;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SPSP.Models.Request.UserAccount;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using SPSP.Services.Customer;

namespace SPSP.Services.Reservation
{
    public class ReservationService 
        : BaseCRUDService<Models.Reservation, Database.Reservation, ReservationSearchObject, ReservationCreateRequest, ReservationUpdateRequest>,
          IReservationService
    {
        public BaseState baseState { get; set; }
        public ICustomerService customerService;
        public ReservationService(BaseState baseState, DataDbContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor, ICustomerService customerService) 
            : base(context, mapper)
        {
            this.baseState = baseState;
            this.customerService = customerService;

        }

        public override IQueryable<Database.Reservation> AddInclude(IQueryable<Database.Reservation> query, ReservationSearchObject search = null)
        {
            if (search.IsQRTableIncluded == true)
            {
                query = query.Include(x => x.QRTable);
            }

            return base.AddInclude(query, search);
        }

        public override IQueryable<Database.Reservation> AddFilter(IQueryable<Database.Reservation> query, ReservationSearchObject? search = null)
        {
            if(search != null)
            {
                if (search.SearchByCustomer != null && search.SearchByCustomer == true)
                {
                    var customer = customerService.GetCustomerAccountInfo();
                    query = query.Where(x => x.CustomerId == customer.Id);
                }

                if (search.StartTime != null)
                {
                    query = query.Where(x => x.StartTime.Date >= search.StartTime.Value.Date);
                }

                if (search.EndTime != null)
                {
                    query = query.Where(x => x.StartTime.Date <= search.EndTime.Value.Date);
                }

                if (search.ReservationStatus != null)
                {
                    query = query.Where(x => x.Status == search.ReservationStatus);
                }

                query = query.OrderByDescending(x => x.StartTime);
            }

            return base.AddFilter(query, search);
        }

        public override async Task<Models.Reservation> Create(ReservationCreateRequest create)
        {
            var state = baseState.CreateState("INITIAL");

            return await state.Create(create);
        }

        public override async Task<Models.Reservation> Update(int id, ReservationUpdateRequest update)
        {
            var dbEntity = await context.Reservations.FindAsync(id);

            var state = baseState.CreateState(dbEntity?.Status);

            return await state.Update(dbEntity, update);
        }

        public async Task<Models.Reservation> ConfirmReservation(int id)
        {
            var entity = await context.Reservations.FindAsync(id);

            var state = baseState.CreateState(entity?.Status);

            return await state.ConfirmReservation(id);
        }

        public async Task<List<string>> GetAllowedActions(int id)
        {
            var entity = await context.Reservations.FindAsync(id);
            var state = baseState.CreateState(entity?.Status);

            return await state.GetAllowedActions();
        }

        public async Task<Models.Reservation> CancelReservation(int id)
        {
            var entity = await context.Reservations.FindAsync(id);

            var state = baseState.CreateState(entity?.Status);

            return await state.CancelReservation(id);
        }

        public async Task<Models.Reservation> SwitchToPendingConfirmation(int id)
        {
            var entity = await context.Reservations.FindAsync(id);

            var state = baseState.CreateState(entity?.Status);

            return await state.SwitchToPendingConfirmation(id);
        }
    }
}
