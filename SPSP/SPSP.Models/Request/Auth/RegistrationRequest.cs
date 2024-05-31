using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPSP.Models.Request.Auth
{
    public class RegistrationRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string FirstName { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string LastName { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Username { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Email { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Compare("PasswordRepeat", ErrorMessage = "Passwords do not match.")]
        public string Password { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Compare("Password", ErrorMessage = "Passwords do not match.")]
        public string PasswordRepeat { get; set; }

    }
}
