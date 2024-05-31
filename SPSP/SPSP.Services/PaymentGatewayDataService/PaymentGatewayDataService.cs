using AutoMapper;
using SPSP.Models.Request.PaymentGatewayData;
using SPSP.Models.SearchObjects;
using SPSP.Services.Database;
using SPSP.Services.Base;
using SPSP.Models.Request;

namespace SPSP.Services.PaymentGatewayData
{
    public class PaymentGatewayDataService : BaseCRUDService<Models.PaymentGatewayData, Database.PaymentGatewayData, BaseSearchObject, PaymentGatewayDataCreateRequest, Object>, IPaymentGatewayDataService
    {
        public PaymentGatewayDataService(DataDbContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

    }
}
