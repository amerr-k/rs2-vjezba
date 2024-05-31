using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class UserAccountUserRole
    {
        public int Id { get; set; }
        public int UserAccountId { get; set; }
        public int UserRoleId { get; set; }
        public bool? Valid { get; set; }

        public virtual UserAccount UserAccount { get; set; }
        public virtual UserRole UserRole { get; set; }
    }
}
