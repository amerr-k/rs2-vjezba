using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models;
using SPSP.Models.Request.QRTable;
using SPSP.Models.Request.UserAccount;
using SPSP.Models.SearchObjects;
using SPSP.Services.QRTable;
using SPSP.Services.UserAccount;
namespace SPSP.Controllers
{
    [ApiController]
    public class QRTableController : BaseCRUDController<QRTable, QRTableSearchObject, QRTableCreateRequest, QRTableUpdateRequest>
    {

        protected new readonly IQRTableService qrTableService;
        public QRTableController(ILogger<BaseCRUDController<QRTable, QRTableSearchObject, QRTableCreateRequest, QRTableUpdateRequest>> logger, IQRTableService service) 
            : base(logger, service)
        {
            qrTableService = service;
        }

        [HttpGet("GetAllByReservationDate")]
        public async Task<List<Models.QRTable>> GetAllByReservationDate([FromQuery] QRTableSearchObject search = null)
        {
            return await qrTableService.GetAllByReservationDate(search);
        }
    }
}
