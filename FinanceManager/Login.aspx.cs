using System;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace FinanceManager
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                int idUser = Database.LoginUser(tbUserName.Text, tbPassword.Text);

                if (idUser != 0)
                {
                    FormsAuthentication.SetAuthCookie(tbUserName.Text, false);
                    Session["idUser"] = idUser;

                    Response.Redirect("/AfterLogin.aspx?id=" + idUser);
                }
                else
                {
                    Response.Redirect("/AfterLogin.aspx");
                }
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        protected string FormatUrlWithID(int idUser)
        {
            return "";
        }

        protected void ValidatePassword(object source, ServerValidateEventArgs args)
        {
            try
            {
                int idUser = Database.LoginUser(tbUserName.Text, tbPassword.Text);
                args.IsValid = (idUser != 0);
            }
            catch
            {
            }
        }
    }
}