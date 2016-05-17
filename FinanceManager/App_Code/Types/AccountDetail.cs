using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public struct AccountDetail
{
    public int IdAccount { get; set; }
    public string Name { get; set; }
    public float Balance { get; set; }
    public DateTime LastUpdate { get; set; }
    public string AccountType { get; set; }
}
