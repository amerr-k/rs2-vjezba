using SPSP.Models;
using System.Text.Json.Serialization;

namespace SPSP.Models
{
    public class UserAuthInfo
    {
        public UserAccount? UserAccount { get; set; }
        public string Token { get; set; }
        public bool IsLoggedIn => UserAccount != null;

        public UserAuthInfo(UserAccount userAccount, string token)
        {
            this.Token = token;
            this.UserAccount = userAccount;
        }

    }
}
