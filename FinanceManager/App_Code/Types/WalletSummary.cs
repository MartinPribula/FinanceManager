using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public struct WalletSummary
{
    public int IdWallet { get; set; }
    public float Balance { get; set; }
    public DateTime LastUpdate { get; set; }
    public int IdUser { get; set; }
    public string WalletName { get; set; }
}