using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Enums
{
    public enum OrderStatusEnum
    {
        ACTIVE,
        COMPLETED,
        CANCELED,
        FAILED
    }

    public static class OrderStatusEnumExtension
    {
        public static string GetValue(this OrderStatusEnum status)
        {
            switch (status)
            {
                case OrderStatusEnum.ACTIVE:
                    return "ACTIVE";
                case OrderStatusEnum.COMPLETED:
                    return "COMPLETED";
                case OrderStatusEnum.CANCELED:
                    return "CANCELED";
                case OrderStatusEnum.FAILED:
                    return "FAILED";
                default:
                    throw new ArgumentException("Invalid OrderStatus");
            }
        }
    }
}
