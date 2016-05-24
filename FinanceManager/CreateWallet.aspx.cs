using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinanceManager
{
    public partial class CreateWallet : System.Web.UI.Page
    {
        int idUser = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                idUser = Database.GetUserId(ticket.Name);

                // posible to have euro sign i textbox
            }

            if (!IsPostBack)
            {
                var data = Database.GetTransactionCategories();

                foreach (var item in data)
                {
                    cblTransactionCategories.Items.Add(new ListItem
                    {
                        Text = item.Name,
                        Value = item.Id.ToString()
                    });
                }
            }
            else
            {

            }
        }

        protected override void LoadViewState(object savedState)
        {
            base.LoadViewState(savedState);
            
        }

        protected void cbAccountCash_checked(object sender, EventArgs e)
        {
            if (!cbAccountCash.Checked)
            {
                tbCashAccountName.Enabled = false;
                tbCashBalance.Enabled = false;
            }
            else
            {
                tbCashAccountName.Enabled = true;
                tbCashBalance.Enabled = true;
            }
        }

        protected void cbAccountBank_checked(object sender, EventArgs e)
        {
            if (!cbAccountBank.Checked)
            {
                tbBankAccountName.Enabled = false;
                tbBankBalance.Enabled = false;
            }
            else
            {
                tbBankAccountName.Enabled = true;
                tbBankBalance.Enabled = true;
            }
        }

        protected void btnCreateWallet_Click(object sender, EventArgs e)
        {
            try
            {
                if (tbBankBalance.Text.Contains(','))
                {
                    tbBankBalance.Text = tbBankBalance.Text.Replace(',', '.');
                }

                if (tbCashBalance.Text.Contains(','))
                {
                    tbCashBalance.Text = tbCashBalance.Text.Replace(',', '.');
                }

                DataTable categoryIds = new DataTable();
                categoryIds.Columns.Add("Id", typeof(int));


                foreach (ListItem item in cblTransactionCategories.Items)
                {
                    if (item.Selected)
                    {
                        categoryIds.Rows.Add(Int32.Parse(item.Value));
                    }
                }

                int idWallet = Database.CreateWallet(idUser, tbWalletName.Text, cbAccountBank.Checked,
                    cbAccountCash.Checked, tbBankAccountName.Text, tbCashAccountName.Text,
                    float.Parse(tbBankBalance.Text), float.Parse(tbCashBalance.Text), categoryIds);

                if (idWallet != 0)
                {

                }
                else
                {

                }
            }
            catch
            {
                
            }
            

        }

        protected void btnNewCategory_Click(object sender, EventArgs e)
        {
            if (cvNewCategory.IsValid)
            {

                int idCategory = Database.CreateCategory(tbNewCategory.Text);

                if (idCategory != 0)
                {
                    cblTransactionCategories.Items.Add(new ListItem
                    {
                        Text = tbNewCategory.Text,
                        Value = idCategory.ToString()
                    });
                }
            }

        }

        protected void ValidateCategory(object senter, ServerValidateEventArgs args)
        {
            int idCategory = Database.CheckCategory(tbNewCategory.Text);
            if (idCategory == 0)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }

        }

    }
}