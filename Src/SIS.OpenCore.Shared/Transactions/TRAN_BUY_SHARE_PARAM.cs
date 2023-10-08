using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIS.OpenCore.Shared.Transactions
{
    public partial class TRAN_BUY_SHARE_PARAM
    {
        public string CIF_NO { get; set; }
        public string Currency { get; set; }
        public string ACCT_NO { get; set; }
        public DateTime TRAN_DT { get; set; }
        public DateTime SETTLMENT_DT { get; set; }
        public short TRAN_TYPE_ID { get; set; }
        public decimal TRAN_QTY { get; set; }
        public decimal UNIT_PRICE { get; set; }
        public decimal TRAN_AMT { get; set; }
    }
}
