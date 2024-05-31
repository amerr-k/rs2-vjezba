using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SPSP.Controllers.Base;
using SPSP.Models.Request.Promotion;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;
using SPSP.Services.Promotion;

namespace SPSP.Controllers
{
    [ApiController] // mora ostati u konkretnom kontroleru zbog swaggera
    public class PromotionController
        : BaseCRUDController<Models.Promotion, PromotionSearchObject, PromotionCreateRequest, PromotionUpdateRequest>
    {

        public PromotionController(ILogger<BaseCRUDController<Models.Promotion, PromotionSearchObject, PromotionCreateRequest, PromotionUpdateRequest>> logger,
            IPromotionService service)
            : base(logger, service)
        {
 
        }

    }
}
