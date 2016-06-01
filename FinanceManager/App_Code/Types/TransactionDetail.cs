using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public class TransactionDetail
{
    public int IdTransaction { get; set; }
    public string TransactionCategory { get; set; }
    public string Ammount { get; set; }
    public string CreationDate { get; set; }
    public int TransactionType { get; set; }
    public string AccountName { get; set; }
}
