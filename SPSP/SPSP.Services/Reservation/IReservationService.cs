using SPSP.Models.Request.Reservation;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SPSP.Services.Reservation
{
    public interface IReservationService
        : ICRUDService<Models.Reservation, ReservationSearchObject, ReservationCreateRequest, ReservationUpdateRequest>
    {
        Task<Models.Reservation> ConfirmReservation(int id);
        Task<Models.Reservation> CancelReservation(int id);
        Task<List<string>> GetAllowedActions(int id);
        Task<Models.Reservation> SwitchToPendingConfirmation(int id);
    }
}
