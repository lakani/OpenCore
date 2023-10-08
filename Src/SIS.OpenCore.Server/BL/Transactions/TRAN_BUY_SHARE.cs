using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Server.BL;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Transactions;
using BAL = SIS.OpenCore.Server.BL.Objects;

namespace SIS.OpenCore.Server.BL.Transactions
{
    public partial class TRAN_BUY_SHARE
    {
        static public Guid Post(TRAN_BUY_SHARE_PARAM buyParam)
        {
            TRN_SHARE_ACCT buyTran = new TRN_SHARE_ACCT();

            if (string.IsNullOrEmpty(buyParam.CIF_NO) == true)
                throw new ArgumentOutOfRangeException("CIF_NO", "CIF_NO doesn't Exists");
            
            if (false == Currency.ValidateExists(buyParam.Currency))
                throw new ArgumentOutOfRangeException("Currency", "Currency doesn't Exists");

            DEF_SHARE_ACCT  SHARE_ACCT = BAL.ShareAccount.Find(
                new DEF_SHARE_ACCT
                {
                    CIF_NO = buyParam.CIF_NO,
                    ACCT_NO = buyParam.ACCT_NO,
                    Currency = buyParam.Currency
                });
            if (SHARE_ACCT == null)
                throw new ArgumentOutOfRangeException("ShareAccount", "Cant Find this Account");

            if (buyParam.TRAN_AMT == 0)
                buyParam.TRAN_AMT = buyParam.TRAN_QTY * buyParam.UNIT_PRICE;


            return new Guid();
        }
    }
}
