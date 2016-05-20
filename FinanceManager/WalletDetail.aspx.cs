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
        protected int idWallet;
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

            Int32.TryParse((string)Request.QueryString["id"], out idWallet);
            if (idUser != Database.CheckWallet(idWallet))
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
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
                        transactions.AddRange(Database.GetTransactionsForAccount(account.IdAccount));
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

                if (txtFrom.Text == null || txtFrom.Text == "")
                {
                    txtFrom.Text = DateTime.Today.ToString("yyyy-MM-dd");
                }
                var data = Database.GetTransactionCategories();

                foreach (var item in data)
                {
                    cblTransactionCategories.Items.Add(new ListItem
                    {
                        Text = item.Name,
                        Value = item.Id.ToString()
                    });
                }
                FillAccounts(idWallet);
            }
            else
            {
                List<TransactionDetail> filteredTransactions = new List<TransactionDetail>();

                var accounts = Database.GetAccountsPerWallet(idWallet);
                if (accounts.Count == 0)
                {
                    //write somewhere, you have nothing in there.
                }
                List<int> idCategories = new List<int>();
                foreach (ListItem item in cblTransactionCategories.Items)
                {
                    if (item.Selected)
                    {
                        idCategories.Add(Int32.Parse(item.Value));
                    }
                }
                int year = Int32.Parse(txtFrom.Text.Substring(0, 4));
                int month = Int32.Parse(txtFrom.Text.Substring(5, 2));
                int day = Int32.Parse(txtFrom.Text.Substring(8, 2));
                DateTime from = new DateTime(year, month, day);

                filteredTransactions = Database.GetFilteredTransactions(idWallet, idCategories, from);

                for (int i = 0; i < filteredTransactions.Count; i++)
                {
                    filteredTransactions[i].Ammount = filteredTransactions[i].Ammount + " \u20AC";
                }

                gwTransactionsResults.DataSource = filteredTransactions;
                gwTransactionsResults.DataBind();
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
            foreach (ListItem item in cblTransactionCategories.Items)
            {
                item.Selected = true;
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {

        }
    }
}