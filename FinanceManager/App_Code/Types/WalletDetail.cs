using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinanceManager.App_Code.Types
{
    public struct WalletDetail
    {
        public int IdWallet { get; set; }
        public float Balance { get; set; }
        public DateTime LastUpdate { get; set; }
        public int IdUser { get; set; }
        public string WalletName { get; set; }
        public List<int> Accounts { get; set; }

    }
}