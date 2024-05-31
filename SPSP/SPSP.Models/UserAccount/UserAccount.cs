using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

#nullable disable

namespace SPSP.Models
{
    public partial class UserAccount
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public bool? Valid { get; set; }
        public virtual ICollection<UserAccountUserRole> UserAccountUserRoles { get; set; } = new List<UserAccountUserRole>();
    }
}
