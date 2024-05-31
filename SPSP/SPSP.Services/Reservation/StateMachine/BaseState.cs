
using AutoMapper;
using SPSP.Models.Request.Reservation;
using SPSP.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using SPSP.Models;

namespace SPSP.Services.Reservation.StateMachine
{
    public class BaseState
    {
        protected readonly DataDbContext context;
        protected readonly IMapper mapper;
        protected readonly IServiceProvider serviceProvider;
        public BaseState(IServiceProvider serviceProvider, DataDbContext context, IMapper mapper)
        {
            this.context = context;
            this.mapper = mapper;
            this.serviceProvider = serviceProvider;
        }


        public virtual Task<Models.Reservation> Create(ReservationCreateRequest create)
        {
            throw new AppException("Not allowed");
        }

        public virtual Task<Models.Reservation> Update(Database.Reservation dbEntity, ReservationUpdateRequest update)
        {
            throw new AppException("Not allowed");
        }

        public virtual Task<Models.Reservation> ConfirmReservation(int id)
        {
            throw new AppException("Not allowed");
        }
        public virtual Task<Models.Reservation> SwitchToPendingConfirmation(int id)
        {
            throw new AppException("Not allowed");
        }
        public virtual Task<Models.Reservation> CancelReservation(int id)
        {
            throw new AppException("Not allowed");
        }

        public BaseState CreateState(string stateName)
        {

            switch (stateName)
            {
                case "INITIAL":
                case null:
                    return serviceProvider.GetService<InitialReservationState>();
                case "CONFIRMED":
                    return serviceProvider.GetService<ConfirmedReservationState>();
                case "PENDING_CONFIRMATION":
                    return serviceProvider.GetService<PendingConfirmationReservationState>();
                default:
                    throw new AppException("Not Allowed");
            }
        }

        public virtual async Task<List<string>> GetAllowedActions()
        {
            return new List<string>();
        }

    }
}
