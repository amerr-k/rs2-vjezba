using SPSP.Models;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.Report
{
    public interface IReportService 
    {
        public Task<List<MenuItemReportData>> GetTopMenuItemsReportData(ReportSearchObject search);
        public Task<List<CustomerReportData>> GetTopCustomersReportData(ReportSearchObject search);
    }
}
