using SPSP.Models.Request.MenuItem;
using SPSP.Models.SearchObjects;
using SPSP.Services.Base;

namespace SPSP.Services.MenuItem
{
    public interface IMenuItemService
        : ICRUDService<Models.MenuItem, MenuItemSearchObject, MenuItemCreateRequest, MenuItemUpdateRequest>
    {

    }
}
