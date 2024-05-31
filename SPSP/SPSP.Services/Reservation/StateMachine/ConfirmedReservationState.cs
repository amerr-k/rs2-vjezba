using AutoMapper;
using SPSP.Services.Database;
using SPSP.Services.Reservation.StateMachine.Generics;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SPSP.Services.Reservation.StateMachine
{
    public class ConfirmedReservationState
        : BaseState
    {
        public ConfirmedReservationState(IServiceProvider serviceProvider, DataDbContext context, IMapper mapper)
            : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Models.Reservation> CancelReservation(int id)
        {
            var set = context.Set<Database.Reservation>();

            var entity = await set.FindAsync(id);

            entity.Status = "CANCELED";

            await context.SaveChangesAsync();

            return mapper.Map<Models.Reservation>(entity);
        }

        public override async Task<List<string>> GetAllowedActions()
        {
            var allowedActions = await base.GetAllowedActions();
            allowedActions.Add("cancel");
            return allowedActions;
        }
    }
}
