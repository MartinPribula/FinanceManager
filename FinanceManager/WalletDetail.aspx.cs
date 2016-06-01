using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
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
            public const string AccountName = "AccountName";
        }

        protected dynamic GetTransactionsDistribution(List<TransactionDetail> transactions)
        {
            var  transactionDistribution = from x in transactions
                                          where x.TransactionType == -1 
                                          group x by x.TransactionCategory into g
                                          select new { Category = (string) g.Key, Value = g.Sum(x => (int) (float.Parse(x.Ammount.Substring(1)))) };

            return transactionDistribution;
        }

        protected void GetBallanceProgress(List<TransactionDetail> transactions, float Ballance, DateTime from, DateTime To)
        {
            transactions = transactions.OrderByDescending(x => x.CreationDate).ToList();
            foreach (var trans in transactions)
            {

            }
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

            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnClearAccount);
            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnClearCategory);

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
                    transactions = Database.GetTransactionsForWallet(idWallet);
                    //foreach (var account in accounts)
                    //{
                    //    transactions.AddRange(Database.GetTransactionsForAccount(account.IdAccount));
                    //}
                    if (transactions.Count == 0)
                    {
                        //write you have 0 trans.
                    }
                    else
                    {
                        var trans = new { categoryCount = GetTransactionsDistribution(transactions) };
                        string smth = "var categoryCounts = " + new JavaScriptSerializer().Serialize(trans) + ";";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "TRANS", smth, true);
                        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "TRANS", smth, true);
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

                if (txtTo.Text == null || txtTo.Text == "")
                {
                    txtTo.Text = DateTime.Today.ToString("yyyy-MM-dd");
                }
                var data = Database.GetTransactionCategoriesForWallet(idWallet);

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

                List<int> idAccounts = new List<int>();
                foreach (ListItem item in cblAccounts.Items)
                {
                    if (item.Selected)
                    {
                        idAccounts.Add(Int32.Parse(item.Value));
                    }
                }

                int year = Int32.Parse(txtFrom.Text.Substring(0, 4));
                int month = Int32.Parse(txtFrom.Text.Substring(5, 2));
                int day = Int32.Parse(txtFrom.Text.Substring(8, 2));
                DateTime from = new DateTime(year, month, day);

                year = Int32.Parse(txtTo.Text.Substring(0, 4));
                month = Int32.Parse(txtTo.Text.Substring(5, 2));
                day = Int32.Parse(txtTo.Text.Substring(8, 2));
                DateTime to = new DateTime(year, month, day);

                filteredTransactions = Database.GetFilteredTransactions(idWallet, idCategories, from, to, idAccounts);
                //var trans = new { categoryCount = GetTransactionsDistribution(filteredTransactions) };
                //string smth = "var categoryCounts = " + new JavaScriptSerializer().Serialize(trans) + ";";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "TRANS", smth, true);

                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "TRANS", smth, true);
                for (int i = 0; i < filteredTransactions.Count; i++)
                {
                    filteredTransactions[i].Ammount = filteredTransactions[i].Ammount + " \u20AC";
                }

                gwTransactionsResults.DataSource = filteredTransactions;
                gwTransactionsResults.DataBind();
                GetTransactionsDistribution(filteredTransactions);
            }

            
        }

        private void FillAccounts(int idWallet)
        {
            var data = Database.GetAccountsPerWallet(idWallet);
            foreach (var item in data)
            {
                cblAccounts.Items.Add(new ListItem
                {
                    Text = item.Name,
                    Value = item.IdAccount.ToString()
                });
            }
        }



        protected void btnClearCategory_Click(object sender, EventArgs e)
        {
            foreach (ListItem item in cblTransactionCategories.Items)
            {
                item.Selected = true;
            }
        }

        protected void btnClearAccounts_Click(object sender, EventArgs e)
        {
            foreach (ListItem item in cblAccounts.Items)
            {
                item.Selected = true;
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {

        }
    }
}