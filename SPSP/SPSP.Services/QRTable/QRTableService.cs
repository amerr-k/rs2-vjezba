using AutoMapper;
using SPSP.Models.Request.QRTable;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;

namespace SPSP.Services.QRTable
{
    public class QRTableService : BaseCRUDService<Models.QRTable, Database.QRTable, QRTableSearchObject, QRTableCreateRequest, QRTableUpdateRequest>, IQRTableService
    {
        public QRTableService(DataDbContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public async Task<Models.QRTable> SetIsTaken(int qrTableId, bool isTaken)
        {
            var qrTableEntity = await context.QRTables.FindAsync(qrTableId);
            if (qrTableEntity != null)
            {
                qrTableEntity.IsTaken = isTaken;
            }

            await context.SaveChangesAsync();

            return mapper.Map<Models.QRTable>(qrTableEntity);
        }

        public async Task<List<Models.QRTable>> GetAllByReservationDate(QRTableSearchObject qrTableSearchObject)
        {
            //var query = from qrt in context.QRTables
            //            join r in context.Reservations.Where(r => r.StartTime == reservationDate)
            //            on qrt.Id equals r.QRTableId into reservations
            //            from res in reservations.DefaultIfEmpty()
            //            select new
            //            {
            //                QRTable = qrt,
            //                IsReserved = res != null ? true : false
            //            };

            var query = await context.QRTables
                .Select(qrt => new
                {
                    QRTable = qrt,
                    IsReserved = qrt.Reservations.Any(r => r.StartTime.Date == qrTableSearchObject.ReservationDate!.Value.Date)
                })
                .ToListAsync();

            return query.ToList()
                .Select(x =>
                {
                    var mappedQRTable = mapper.Map<Models.QRTable>(x.QRTable);
                    mappedQRTable.IsReserved = x.IsReserved;
                    return mappedQRTable;
                })
                .ToList();
        }

    }
}
