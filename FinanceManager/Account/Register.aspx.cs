using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Membership.OpenAuth;
using System.Data.SqlClient;
using Antlr.Runtime.Tree;

namespace FinanceManager.Account
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }



        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                int idUser = Database.CreateUser(UserName.Text, FirstName.Text, LastName.Text, Email.Text, Password.Text);

                if (idUser != 0)
                {
                    FormsAuthentication.SetAuthCookie(UserName.Text + "|" + idUser, true);

                    //Session["UserId"] = dr["idRet"];
                    //Session["UserName"] = UserName.Text;
                    //Session["UserPassword"] = Password.Text;

                    Response.Redirect("/SuccessRegister.aspx");
                }
                else
                {
                    Response.Redirect("/Default.aspx");
                }
            }
            catch
            {

            }
        }
    }
}