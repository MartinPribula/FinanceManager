using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace FinanceManager
{
    public partial class AfterLogin : Page
    {
        protected static class TableColumns
        {
            public const string IdWallet = "IdWallet";
            public const string Balance = "Balance";
            public const string LastUpdate = "LastUpdate";
            public const string IdUser = "IdUser";
            public const string WalletName = "WalletName";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            int idUser = 0;
            if (Request.IsAuthenticated)
            {
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                idUser = Database.GetUserId(ticket.Name);
            }
            else
            {
                Response.Redirect("Default.aspx");
            }

            if (idUser != 0)
            {
                var data = Database.GetUserWallets(idUser);
                if (data.Count == 0)
                {
                    Response.Redirect("CreateWallet.aspx");
                }
                repeaterResult.DataSource = data;
                repeaterResult.DataBind();
            }

        }


    }
}