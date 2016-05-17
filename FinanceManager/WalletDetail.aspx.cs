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
    public partial class WalletDetail : System.Web.UI.Page
    {

        protected static class TableColumns
        {
            public const string IdTransaction = "IdTransaction";
            public const string TransactionCategory = "TransactionCategory";
            public const string Ammount = "Ammount";
            public const string CreationDate = "CreationDate";
            public const string TransactionType = "TransactionType";
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

            int idWallet = 0;
            Int32.TryParse((string)Request.QueryString["id"], out idWallet);
            if (idUser != Database.CheckWallet(idWallet))
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                LoadDdlValues(idWallet);
                FillAccounts(idWallet);
            }

            if (idUser != 0)
            {
                var accounts = Database.GetAccountsPerWallet(idWallet);
                if (accounts.Count == 0)
                {
                    //write somewhere, you have nothing in there.
                }
                else
                {
                    List<TransactionDetail> transactions = new List<TransactionDetail>();
                    foreach (var account in accounts)
                    {
                        transactions.AddRange(Database.GetTransactionsForAccount(account.IdAccount)) ;
                    }
                    if (transactions.Count == 0)
                    {
                        //write you have 0 trans.
                    }
                    else
                    {
                        for (int i = 0; i < transactions.Count; i++)
                        {
                            transactions[i].Ammount = transactions[i].Ammount + " \u20AC";
                        }
                        gwTransactionsResults.DataSource = transactions;
                        gwTransactionsResults.DataBind();
                    }
                }
                
            }
        }


        private void LoadDdlValues(int idWallet)
        {
            var data = Database.GetDdlTransactionCategoryValues(idWallet);

            ddlCategory.Items.Clear();
            ddlCategory.Items.Add(new ListItem { Value = "", Text = "Všerky kategórie." });
            foreach (var item in data)
            {
                ddlCategory.Items.Add(new ListItem { Value = item.Id.ToString(), Text = item.Name });
            }
        }

        private void FillAccounts(int idWallet)
        {
            var data = Database.GetAccountsPerWallet(idWallet);
            ddlAccounts.Items.Clear();
            ddlAccounts.Items.Add(new ListItem { Value = "", Text = "Všetky" });
            foreach (var item in data)
            {
                ddlAccounts.Items.Add(new ListItem { Value = item.IdAccount.ToString(), Text = item.Name });
            }
        }



        protected void btnClearCategory_Click(object sender, EventArgs e)
        {
            ddlCategory.SelectedValue = "";
        }
    }
}