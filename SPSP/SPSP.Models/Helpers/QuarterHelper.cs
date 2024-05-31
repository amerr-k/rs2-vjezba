using SPSP.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Helpers
{

    public class QuarterHelper
    {
        public static DateRange GetDateRange(ReportSearchObject searchObject)
        {
            DateTime startDate, endDate;

            switch (searchObject.Quarter)
            {
                case "Q1":
                    startDate = new DateTime(DateTime.Now.Year, 1, 1);
                    endDate = new DateTime(DateTime.Now.Year, 3, 31);
                    break;
                case "Q2":
                    startDate = new DateTime(DateTime.Now.Year, 4, 1);
                    endDate = new DateTime(DateTime.Now.Year, 6, 30);
                    break;
                case "Q3":
                    startDate = new DateTime(DateTime.Now.Year, 7, 1);
                    endDate = new DateTime(DateTime.Now.Year, 9, 30);
                    break;
                case "Q4":
                    startDate = new DateTime(DateTime.Now.Year, 10, 1);
                    endDate = new DateTime(DateTime.Now.Year, 12, 31);
                    break;
                default:
                    startDate = new DateTime(DateTime.Now.Year, 1, 1);
                    endDate = new DateTime(DateTime.Now.Year, 12, 31);
                    break;
            }

            return new DateRange { StartDate = startDate, EndDate = endDate };
        }
    }

    public class DateRange
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }
}
