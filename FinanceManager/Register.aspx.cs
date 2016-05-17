using System;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace FinanceManager
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                if (cvUserName.IsValid)
                {
                    PasswordHash hash = new PasswordHash(tbPassword.Text);
                    byte[] hashBytes = hash.ToArray();
                    string passwordHash = Convert.ToBase64String(hashBytes);

                    int idUser = Database.CreateUser(tbUserName.Text, tbFirstName.Text, tbLastName.Text, tbEmail.Text, passwordHash);

                    if (idUser != 0)
                    {
                        FormsAuthentication.SetAuthCookie(tbUserName.Text, false);
                        Session["idUser"] = idUser;

                        Response.Redirect("/SuccessRegister.aspx");
                    }
                    else
                    {
                        Response.Redirect("/Default.aspx");
                    }
                }
            }
            catch
            {
                
            }
        }

        protected void ValidateUserName_Leave(object senter, EventArgs e)
        {
            bool userExists = Database.CheckUser(tbUserName.Text);
            cvUserName.IsValid = !userExists;

        }

        protected void ValidateUserName(object senter, ServerValidateEventArgs args)
        {
            bool userExists = Database.CheckUser(tbUserName.Text);
            args.IsValid = !userExists;

        }
    }
}