﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
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
        protected float balance = 0;
        protected float spendings = 0;
        protected float gains = 0;
        protected DateTime last;
        protected DateTime first;

        protected static class TableColumns
        {
            public const string IdTransaction = "IdTransaction";
            public const string TransactionCategory = "TransactionCategory";
            public const string Ammount = "Ammount";
            public const string CreationDate = "CreationDate";
            public const string TransactionType = "TransactionType";
            public const string AccountName = "AccountName";
            public const string Description = "Description";
        }

        protected dynamic GetTransactionsDistribution(List<TransactionDetail> transactions)
        {
            var transactionDistribution = from x in transactions
                                          where x.TransactionType == -1 && x.TransactionCategory != "Výber hotovosti"
                                          group x by x.TransactionCategory into g
                                          select new { Category = (string)g.Key, Value = g.Sum(x => (int)(float.Parse(x.Ammount.Substring(1)))) };

            return transactionDistribution;
        }

        protected List<float> GetBallanceProgress(List<TransactionDetail> transactions, float Ballance)
        {
            DateTime now = DateTime.Now;
            string nowStr = now.ToString("dd/MM/yyyy");
            int year = Int32.Parse(nowStr.Substring(6, 4));
            int month = Int32.Parse(nowStr.Substring(3, 2)) - 1;
            int day = Int32.Parse(nowStr.Substring(0, 2));
            first = new DateTime(year, month, 1);
            int[] longMonths = { 1, 3, 5, 7, 8, 10, 12 };
            //DateTime last;
            if (longMonths.Contains(month))
            {
                last = new DateTime(year, month, 31);
            }
            else if (month == 2 && year % 4 != 0)
            {
                last = new DateTime(year, month, 28);
            }
            else if (month == 2 && year % 4 == 0)
            {
                last = new DateTime(year, month, 29);
            }
            else
            {
                last = new DateTime(year, month, 30);
            }




            List<float> values = new List<float>();

            values.Add(Ballance);
            int i = -1;
            while (DateTime.Now.AddDays(i) >= first)
            {
                var trans = transactions.Where(x => x.CreationDate == DateTime.Now.AddDays(i).ToString("dd/MM/yyyy")).ToList();
                float dayAmount = 0;
                foreach (var tran in trans)
                {
                    dayAmount += float.Parse(tran.Ammount);
                }
                Ballance += -dayAmount;
                values.Add(Ballance);
                i--;
            }
            values.Reverse();
            values = values.Take(last.Day).ToList();


            return values;
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

                    

                    foreach (var account in accounts)
                    {
                        balance += account.Balance;
                    }

                    if (transactions.Count == 0)
                    {
                        //write you have 0 trans.
                    }
                    else
                    {
                        var transPie = new { categoryCount = GetTransactionsDistribution(transactions) };
                        string jsonPie = "var categoryCounts = " + new JavaScriptSerializer().Serialize(transPie) + ";";
                        ScriptManager.RegisterStartupScript(ContentPanel, ContentPanel.GetType(), "tranCount", jsonPie, true);
                        ScriptManager.RegisterStartupScript(ContentPanel, ContentPanel.GetType(), "scriptPie", "<script src=\"Scripts/MyScripts/PieChartCategories.js\" type=\"text/javascript\"></script>", false);

                        var transLine = new { balProg = GetBallanceProgress(transactions, balance) };
                        string jsonLine = "var balanceProgress = " + new JavaScriptSerializer().Serialize(transLine) + ";";
                        ScriptManager.RegisterStartupScript(ContentPanel, ContentPanel.GetType(), "balProg", jsonLine, true);
                        ScriptManager.RegisterStartupScript(ContentPanel, ContentPanel.GetType(), "scriptLine", "<script src=\"Scripts/MyScripts/LineGraphBalance.js\" type=\"text/javascript\"></script>", false);

                        var transNum = Database.GetTransactionsInInterval(idWallet, first, last);

                        foreach (var item in transNum)
                        {
                            if (item.TransactionType == 1)
                            {
                                spendings += item.Ammount;
                            }
                            else
                            {
                                gains += item.Ammount;
                            }
                        }

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
                    txtFrom.Text = DateTime.Today.AddDays(-30).ToString("yyyy-MM-dd");
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

                foreach (ListItem item in cblAccounts.Items)
                {
                    item.Selected = true;
                }

                foreach (ListItem item in cblTransactionCategories.Items)
                {
                    item.Selected = true;
                }

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
                var trans = new { categoryCount = GetTransactionsDistribution(filteredTransactions) };
                string smth = "var categoryCounts = " + new JavaScriptSerializer().Serialize(trans) + ";";

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

        private void GetWalletDetail(int idWallet)
        {

        }

    }
}