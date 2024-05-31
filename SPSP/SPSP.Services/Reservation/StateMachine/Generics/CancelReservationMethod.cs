using AutoMapper;
using SPSP.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Services.Reservation.StateMachine.Generics
{
    public class CancelReservationMethod : BaseState, ICancelReservationMethod
    {
        public CancelReservationMethod(IServiceProvider serviceProvider, DataDbContext context, IMapper mapper)
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
    }

}
