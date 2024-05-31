using SPSP.Models.Request;
using SPSP.Models.Request.PaymentGatewayData;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.PaymentGatewayData
{
    public interface IPaymentGatewayDataService
        : ICRUDService<Models.PaymentGatewayData, BaseSearchObject, PaymentGatewayDataCreateRequest, Object>
    {

    }
}
