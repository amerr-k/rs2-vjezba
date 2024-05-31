using AutoMapper;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Models;
using SPSP.Models.Helpers;
using Microsoft.EntityFrameworkCore;

namespace SPSP.Services.Report
{
    public class ReportService : IReportService
    {
        protected readonly DataDbContext context;
        protected readonly IMapper mapper;

        public ReportService(DataDbContext context, IMapper mapper)
        {
            this.mapper = mapper; 
            this.context = context;
        }

        public async Task<List<CustomerReportData>> GetTopCustomersReportData(ReportSearchObject search)
        {
            var dateRange = QuarterHelper.GetDateRange(search);

            var query = (from c in context.Customers
                         join o in context.Orders on c.Id equals o.CustomerId
                         join ua in context.UserAccounts on c.UserAccountId equals ua.Id
                         where o.Status == "COMPLETED" &&
                             (o.OrderDateTime.Date >= dateRange.StartDate || search.Quarter == null) &&
                             (o.OrderDateTime.Date <= dateRange.EndDate || search.Quarter == null)
                         group new { c, o, ua } by new { ua.FirstName, ua.LastName, c.Phone, ua.Email } into grouped
                         orderby grouped.Sum(x => x.o.TotalAmountWithVAT) descending
                         select new CustomerReportData
                         {
                             FirstName = grouped.Key.FirstName,
                             LastName = grouped.Key.LastName,
                             Phone = grouped.Key.Phone,
                             Email = grouped.Key.Email,
                             OrderCount = grouped.Count(),
                             TotalAmount = grouped.Sum(x => x.o.TotalAmountWithVAT)
                         }).Take(10);

            return await query.ToListAsync();
        }

        public async Task<List<MenuItemReportData>> GetTopMenuItemsReportData(ReportSearchObject search)
        {
            var dateRange = QuarterHelper.GetDateRange(search);

            var query = (from mi in context.MenuItems
                         join oi in context.OrderItems on mi.Id equals oi.MenuItemId
                         join o in context.Orders on oi.OrderId equals o.Id
                         join c in context.Categories on mi.CategoryId equals c.Id
                         where o.Status == "COMPLETED" &&
                               o.OrderDateTime.Date >= dateRange.StartDate.Date &&
                               o.OrderDateTime.Date <= dateRange.EndDate.Date
                         group new { mi, oi } by new { mi.Name, Category = c.Name, mi.Price } into g
                         orderby g.Sum(x => x.oi.Subtotal) descending
                         select new MenuItemReportData
                         {
                             Name = g.Key.Name,
                             Category = g.Key.Name,
                             Price = g.Key.Price ?? 0,
                             OrderCount = g.Sum(x => x.oi.Quantity),
                             TotalAmount = g.Sum(x => x.oi.Subtotal) ?? 0
                         }).Take(10);

            return await query.ToListAsync();
        }
    }

}

