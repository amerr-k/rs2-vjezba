using System.ComponentModel.DataAnnotations;

namespace SPSP.Models.Request.UserAccount
{
    public class UserAccountUpdateRequest
    {
        [Required(AllowEmptyStrings =false)]
        public string FirstName { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string LastName { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Username { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Email { get; set; }
    }
}
