using SPSP.Models.Request.Reservation;
using System.Threading.Tasks;

namespace SPSP.Services.Reservation.StateMachine.Generics
{
    public interface ICancelReservationMethod
    {
        Task<Models.Reservation> CancelReservation(int id);
    }
}
