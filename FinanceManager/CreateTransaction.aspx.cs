using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinanceManager
{
    public partial class CreateTransaction : System.Web.UI.Page
    {
        protected int idWallet = 0;

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

            Int32.TryParse((string)Request.QueryString["id"], out idWallet);
            if (idUser != Database.CheckWallet(idWallet))
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                //txtCreateDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                FillCategories(idWallet);
                FillAccounts(idWallet);
            }
            else
            {
                if (txtAmount.Text != "")
                {
                    float amount = float.Parse(txtAmount.Text);
                    if (rblTransactionType.SelectedValue == "outgoing")
                    {
                        if (amount > 0)
                            txtAmount.Text = (-1 * amount).ToString();
                    }
                    else
                    {
                        if (amount < 0)
                        {
                            txtAmount.Text = (-1 * amount).ToString();
                        }
                    }
                }
                if (ddlCategory.SelectedValue == "13")
                {
                    foreach (ListItem item in rblTransactionType.Items)
                    {
                        if (item.Value == "outgoing")
                        {
                            item.Selected = true;
                            rblTransactionType.Enabled = false;
                            lbAtmCash.Visible = true;
                            if (ddlAtmCash.SelectedItem == null)
                            {
                                fillCashAccounts();
                            }
                            ddlAtmCash.Visible = true;
                        }
                    }
                }
                else
                {
                    rblTransactionType.Enabled = true;
                    ddlAtmCash.Visible = false;
                    lbAtmCash.Visible = false;
                }

            }

            if (txtCreateDate.Text == null || txtCreateDate.Text == "")
            {
                txtCreateDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }


        }

        private void FillAccounts(int idWallet)
        {
            var data = Database.GetAccountsPerWallet(idWallet);
            ddlAccount.Items.Clear();
            ddlAccount.Items.Add(new ListItem { Value = "", Text = "Nešpecifikované" });
            foreach (var item in data)
            {
                ddlAccount.Items.Add(new ListItem { Value = item.IdAccount.ToString(), Text = item.Name });
            }
        }

        private void FillCategories(int idWallet)
        {
            var data = Database.GetDdlTransactionCategoryValues(idWallet);

            ddlCategory.Items.Clear();
            ddlCategory.Items.Add(new ListItem { Value = "", Text = "Nešpecifikované" });
            foreach (var item in data)
            {
                ddlCategory.Items.Add(new ListItem { Value = item.Id.ToString(), Text = item.Name });
            }
        }

        private void fillCashAccounts()
        {
            var data = Database.GetCashAccountsPerWallet(idWallet);
            ddlAtmCash.Items.Clear();
            ddlAtmCash.Items.Add(new ListItem { Value = "", Text = "Nešpecifikované" });
            foreach (var item in data)
            {
                ddlAtmCash.Items.Add(new ListItem { Value = item.IdAccount.ToString(), Text = item.Name });
            }
        }


        protected void rbCategory_Click(object sender, EventArgs e)
        {
            float amount = float.Parse(txtAmount.Text);
            if (rblTransactionType.SelectedValue == "outgoing")
            {
                if (amount > 0)
                {
                    txtAmount.Text = (-1 * amount).ToString();
                }
                txtAmount.CssClass = "outgoingTransaction";
            }
            else
            {
                if (amount < 0)
                {
                    txtAmount.Text = (-1 * amount).ToString();
                }
                txtAmount.CssClass = "incomingTransaction";
            }
        }

        protected void btnNewTransaction_Click(object sender, EventArgs e)
        {
            float ammount = float.Parse(txtAmount.Text);
            int transactionType = 0;

            if (rblTransactionType.SelectedValue == "outgoing")
            {
                transactionType = -1;
                if (ammount > 0)
                {
                    ammount *= -1;
                }
            }
            else if (rblTransactionType.SelectedValue == "incoming")
            {
                transactionType = 1;
                if (ammount < 0)
                {
                    ammount *= -1;
                }
            }

            int idTransaction = Database.CreateTransaction(idWallet, Int32.Parse(ddlAccount.SelectedValue), Int32.Parse(ddlCategory.SelectedValue), ammount, tbDescription.Text, txtCreateDate.Text, transactionType);

            if (ddlCategory.SelectedValue == "13")
            {
                int idTransactionCash = Database.CreateTransaction(idWallet, Int32.Parse(ddlAtmCash.SelectedValue), Int32.Parse(ddlCategory.SelectedValue), ammount * (-1), tbDescription.Text, txtCreateDate.Text, transactionType * (-1));
            }

            Response.Redirect("/WalletDetail.aspx?id=" + idWallet);

        }

    }
}