using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SPSP.Controllers.Base;
using SPSP.Models.Request.Auth;
using SPSP.Models.Request.UserAccount;
using SPSP.Models.SearchObjects;
using SPSP.Services.QRTable;
using SPSP.Services.Report;
using SPSP.Services.UserAccount;

namespace SPSP.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ReportController
    {
        readonly IReportService reportService;
        readonly ILogger<ReportController> logger;

        public ReportController(ILogger<ReportController> logger, IReportService reportService)
        {
            this.reportService = reportService;
        }

        [HttpGet("MenuItems")]
        public async Task<List<Models.MenuItemReportData>> GetMenuItemsReportData([FromQuery] ReportSearchObject search = null)
        {
            return await reportService.GetTopMenuItemsReportData(search);
        }

        [HttpGet("Customers")]
        public async Task<List<Models.CustomerReportData>> GetCustomersReportData([FromQuery] ReportSearchObject search = null)
        {
            return await reportService.GetTopCustomersReportData(search);
        }

    }
}
