using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class UserRole
    {
        public UserRole()
        {
            UserAccountUserRoles = new HashSet<UserAccountUserRole>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public bool? Valid { get; set; }

        public virtual ICollection<UserAccountUserRole> UserAccountUserRoles { get; set; }
    }
}
