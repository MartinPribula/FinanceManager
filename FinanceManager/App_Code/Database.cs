using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Transactions;
using System.Web.UI;

namespace FinanceManager
{
    public static class Database
    {
        #region Common

        public static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            }
        }

        public static SqlConnection CreateConnection()
        {
            var connection = new SqlConnection(ConnectionString);
            connection.Open();
            return connection;
        }

        public static SqlCommand CreateCommand(SqlConnection connection, string procedureName)
        {
            var command = connection.CreateCommand();
            command.CommandText = procedureName;
            command.CommandType = CommandType.StoredProcedure;
            command.Connection = connection;
            return command;
        }
        #endregion

        public static int CreateUser(string UserName, string FirstName, string LastName, string Email, string Password)
        {
            int idUser = 0;
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CreateUser"))
                    {

                        command.Parameters.AddWithValue("@FirstName", FirstName);
                        command.Parameters.AddWithValue("@LastName", LastName);
                        command.Parameters.AddWithValue("@UserName", UserName);
                        command.Parameters.AddWithValue("@Email", Email);
                        command.Parameters.AddWithValue("@Password", Password);

                        command.ExecuteNonQuery();
                    }

                    using (var command = CreateCommand(connection, "sp_GetUserId"))
                    {
                        command.Parameters.AddWithValue("@userName", UserName);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                idUser = reader.GetInt32(0);
                            }
                        }

                    }

                }
                transaction.Complete();
            }

            return idUser;
        }

        public static int LoginUser(string userName, string password)
        {
            int idUser = 0;
            string databasePassword="";
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetPassword"))
                    {

                        command.Parameters.AddWithValue("@userName", userName);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                databasePassword = reader.GetString(0);
                                idUser = reader.GetInt32(1);
                            }
                        }

                    }
                }
                transaction.Complete();
            }

            //overit heslo ci je spravne
            byte[] hashBytes = Convert.FromBase64String(databasePassword);
            PasswordHash hash = new PasswordHash(hashBytes);
            if (!hash.Verify(password))
            {
                return 0;
            }
            else
            {
                return idUser;
            }
        }


        internal static int GetUserId(string userName)
        {
            int idUser = 0;
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CheckUser"))
                    {

                        command.Parameters.AddWithValue("@userName", userName);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                idUser = reader.GetInt32(0);
                            }
                        }

                    }
                }
                transaction.Complete();
            }
            return idUser;
        }


        internal static bool CheckUser(string userName)
        {
            int idUser = 0;
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CheckUser"))
                    {

                        command.Parameters.AddWithValue("@userName", userName);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                idUser = reader.GetInt32(0);
                            }
                        }

                    }
                }
                transaction.Complete();
            }
            return idUser != 0;
        }

        public static int CreateWallet(int idUser, string walletName, bool cashChecked, bool bankChecked, string accountName, string cashName, float accountBalance, float cashBallance, DataTable categoryIds)
        {
            int idWallet = 0;

            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CreateWallet"))
                    {

                        command.Parameters.AddWithValue("@idUser", idUser);
                        command.Parameters.AddWithValue("@WalletName", walletName);
                        command.Parameters.AddWithValue("@TransactionCategoryList", categoryIds);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                idWallet = reader.GetInt32(0);
                            }
                        }

                    }
                }
                transaction.Complete();
            }
            if (idWallet != 0)
            {
                if (cashChecked)
                {
                    int idAccount = CreateAccount(idWallet, cashName, "Cash", cashBallance);
                }
                if(bankChecked)
                {
                    int idAccount = CreateAccount(idWallet, accountName, "Virtual", accountBalance);
                }
            }
            return idWallet;
        }

        public static int CreateAccount(int idWallet, string accountName, string accountType, float ballance)
        {
            int idAccount = 0;
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CreateAccount"))
                    {

                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        command.Parameters.AddWithValue("@AccountName", accountName);
                        command.Parameters.AddWithValue("@AccountType", accountType);
                        command.Parameters.AddWithValue("@AccountBallance", ballance);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                idAccount = reader.GetInt32(0);
                            }
                        }

                    }
                }
                transaction.Complete();
            }
            return idAccount;
        }

        public static List<WalletSummary> GetUserWallets(int idUser)
        {

            var result = new List<WalletSummary>();

            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetUserWallets"))
                    {
                        command.Parameters.AddWithValue("@idUser", idUser);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new WalletSummary
                                {
                                    IdWallet = reader.GetInt32(0),
                                    Balance = (float)reader.GetDecimal(1),
                                    LastUpdate = reader.GetDateTime(2),
                                    IdUser = reader.GetInt32(3),
                                    WalletName = reader.GetString(4)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static void GetWalletDetail(int idWallet)
        {
            var result = new List<WalletSummary>();

            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_WalletDetail"))
                    {
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new WalletSummary
                                {
                                    IdWallet = reader.GetInt32(0),
                                    Balance = (float)reader.GetDecimal(1),
                                    LastUpdate = reader.GetDateTime(2),
                                    IdUser = reader.GetInt32(3),
                                    WalletName = reader.GetString(4)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            //return result;
        }

        public static int CheckWallet(int idWallet)
        {
            int idUser = 0;
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CheckWallet"))
                    {
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                idUser = reader.GetInt32(0);
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return idUser;
        }

        public static List<AccountDetail> GetAccountsPerWallet(int idWallet)
        {
            var result = new List<AccountDetail>();
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetAccountsPerWallet"))
                    {
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new AccountDetail
                                {
                                    IdAccount = reader.GetInt32(0),
                                    Name = reader.GetString(1),
                                    Balance = (float)reader.GetDecimal(2),
                                    LastUpdate = reader.GetDateTime(3),
                                    AccountType = reader.GetString(4)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static List<TransactionDetail> GetTransactionsForAccount(int idAccount)
        {
            var result = new List<TransactionDetail>();
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetTransactionsPerAccount"))
                    {
                        command.Parameters.AddWithValue("@idAccount", idAccount);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new TransactionDetail
                                {
                                    IdTransaction = reader.GetInt32(0),
                                    TransactionCategory = reader.GetString(1),
                                    Ammount = ((float) reader.GetDecimal(2)).ToString(),
                                    CreationDate = reader.GetString(3),
                                    TransactionType = reader.GetInt32(4)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static List<TransactionCategoryIdName> GetDdlTransactionCategoryValues(int idWallet)
        {
            var result = new List<TransactionCategoryIdName>();
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetTransactionCategoriesForWallet"))
                    {
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new TransactionCategoryIdName
                                {
                                    Id = reader.GetInt32(0),
                                    Name = reader.GetString(1)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static List<TransactionCategoryIdName> GetTransactionCategories()
        {
            var result = new List<TransactionCategoryIdName>();
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetTransactionCategories"))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new TransactionCategoryIdName
                                {
                                    Id = reader.GetInt32(0),
                                    Name = reader.GetString(1)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static int CreateTransaction(int idWallet, int idAccount, int idCategory, float ammount, string description, string creationDateStr, int transactionType)
        {
            int transactionId = 0;
            DateTime creationDate = Convert.ToDateTime(creationDateStr);
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CreateNewTransaction"))
                    {
                        command.Parameters.AddWithValue("@idAccount", idAccount);
                        command.Parameters.AddWithValue("@Ammount", ammount);
                        command.Parameters.AddWithValue("@idCategory", idCategory);
                        command.Parameters.AddWithValue("@CreationDate", creationDate);
                        command.Parameters.AddWithValue("@Description", description);
                        command.Parameters.AddWithValue("@TransactionType", transactionType);
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                transactionId = reader.GetInt32(0);
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return transactionId;
        }


        public static List<TransactionDetail> GetFilteredTransactions(int idWallet, List<int> idCategories, DateTime from, DateTime to, List<int> idAccounts)
        {
            var result = new List<TransactionDetail>();
            DataTable categories = new DataTable();
            categories.Columns.Add("TransactionCategoryId", type: typeof(int));
            foreach (int item in idCategories)
            {
                categories.Rows.Add(new Object[] {item});
            }

            DataTable accounts = new DataTable();
            accounts.Columns.Add("AccountId", type: typeof(int));
            foreach (int item in idAccounts)
            {
                accounts.Rows.Add(new Object[] { item });
            }

            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_TransPerMonthCategory"))
                    {
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        command.Parameters.AddWithValue("@fromDate", from);
                        command.Parameters.AddWithValue("@toDate", to);
                        command.Parameters.AddWithValue("@idCategories", categories);
                        command.Parameters.AddWithValue("@idAccounts", accounts);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new TransactionDetail
                                {
                                    IdTransaction = reader.GetInt32(0),
                                    TransactionCategory = reader.GetString(1),
                                    Ammount = ((float)reader.GetDecimal(2)).ToString(),
                                    CreationDate = reader.GetString(3),
                                    TransactionType = reader.GetInt32(4),
                                    AccountName = reader.GetString(5)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static List<TransactionDetail> GetTransactionsForWallet(int idWallet)
        {
            var result = new List<TransactionDetail>();
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetTransactionsPerWallet"))
                    {
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new TransactionDetail
                                {
                                    IdTransaction = reader.GetInt32(0),
                                    TransactionCategory = reader.GetString(1),
                                    Ammount = ((float)reader.GetDecimal(2)).ToString(),
                                    CreationDate = reader.GetString(3),
                                    TransactionType = reader.GetInt32(4),
                                    AccountName = reader.GetString(5)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static List<TransactionCategoryIdName> GetTransactionCategoriesForWallet(int idWallet)
        {
            var result = new List<TransactionCategoryIdName>();
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_GetTransactionCategoriesForWallet"))
                    {
                        command.Parameters.AddWithValue("@idWallet", idWallet);
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                result.Add(new TransactionCategoryIdName
                                {
                                    Id = reader.GetInt32(0),
                                    Name = reader.GetString(1)
                                });
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return result;
        }

        public static int CreateCategory(string Name)
        {
            int idCategory = 0;
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CreateCategory"))
                    {
                        command.Parameters.AddWithValue("@CategoryName", Name);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                idCategory = reader.GetInt32(0);
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return idCategory;
        }

        public static int CheckCategory(string Name)
        {
            int idCategory = 0;
            using (var transaction = new TransactionScope())
            {
                using (var connection = CreateConnection())
                {
                    using (var command = CreateCommand(connection, "sp_CheckCategory"))
                    {
                        command.Parameters.AddWithValue("@CategoryName", Name);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                idCategory = reader.GetInt32(0);
                            }
                        }
                    }
                }
                transaction.Complete();
            }
            return idCategory;
        }


    }

    
}