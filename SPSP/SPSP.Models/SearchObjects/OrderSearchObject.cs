using SPSP.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.SearchObjects
{
    public class OrderSearchObject : BaseSearchObject
    {
        public DateTime? orderDateTimeFrom {  get; set; }
        public DateTime? orderDateTimeTo {  get; set; }
        public OrderStatusEnum? orderStatus {  get; set; }
        public bool? IsOrderItemsIncluded { get; set; }
        public bool? IsQRTablesIncluded { get; set; }
        public bool? SearchByCustomer { get; set; }
        public int? QRTableId { get; set; }
        public string? Status { get; set; }
    }
}
