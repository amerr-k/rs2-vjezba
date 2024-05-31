using SPSP.Models.Request.Promotion;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.Promotion
{
    public interface IPromotionService
        : ICRUDService<Models.Promotion, PromotionSearchObject, PromotionCreateRequest, PromotionUpdateRequest>
    {

    }
}
