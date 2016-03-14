using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Transactions;

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

        public static SqlDataReader CreateUser(string UserName, string FirstName, string LastName, string Email, string Password)
        {
            SqlDataReader dr;
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

                        //command.ExecuteNonQuery();
                        dr = command.ExecuteReader();
                        dr.Read();
                    }
                }
                transaction.Complete();
            }
            return dr;
        }
    }
}