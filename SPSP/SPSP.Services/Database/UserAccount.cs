using System;
using System.Collections.Generic;

#nullable disable

namespace SPSP.Services.Database
{
    public partial class UserAccount
    {
        public UserAccount()
        {
            Customers = new HashSet<Customer>();
            Employees = new HashSet<Employee>();
            UserAccountUserRoles = new HashSet<UserAccountUserRole>();
        }

        public int Id { get; set; }
        public string Username { get; set; }
        public string PasswordSalt { get; set; }
        public string PasswordHash { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public bool? Registered { get; set; }
        public bool? Valid { get; set; }

        public virtual ICollection<Customer> Customers { get; set; }
        public virtual ICollection<Employee> Employees { get; set; }
        public virtual ICollection<UserAccountUserRole> UserAccountUserRoles { get; set; }
    }
}
