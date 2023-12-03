using System;
using System.Linq;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Server.Data.Context;

namespace SIS.OpenCore.Server.Data
{
    public partial class ShareAccount
    {
        /// <summary>
        /// Return the MAX Code
        /// </summary>
        static public string GetMaxCode()
        {
            OpenCoreContext db = new OpenCoreContext();
            string stMaxCode = (from r in db.DEF_SHARE_ACCT
                                select r.ACCT_NO).Max();
            return stMaxCode;
        }

        /// <summary>
        /// Return the MAX Code
        /// </summary>
        static public DEF_SHARE_ACCT Find(DEF_SHARE_ACCT toFind)
        {
            OpenCoreContext db = new OpenCoreContext();
            
            return  (from r in db.DEF_SHARE_ACCT
                    where r.Name == toFind.Name && r.CIF_NO == toFind.CIF_NO && r.Currency == toFind.Currency
                    select r).FirstOrDefault();
        }


        /// <summary>
        /// Insert new Fixed Rate Account into the Database
        /// </summary>
        static public string Create(DEF_SHARE_ACCT NewAcct)
        {
            DEF_SHARE_ACCT NewAcct_EL = new DEF_SHARE_ACCT();
            OpenCoreContext db = new OpenCoreContext();

            NewAcct_EL.ACCT_NO = NewAcct.ACCT_NO;
            NewAcct_EL.ACCT_CLASS = NewAcct.ACCT_CLASS;
            NewAcct_EL.ACCT_TYPE = NewAcct.ACCT_TYPE;
            NewAcct_EL.CIF_NO = NewAcct.CIF_NO;
            NewAcct_EL.CompanyNo = NewAcct.CompanyNo;
            NewAcct_EL.CSP_Code = NewAcct.CSP_Code;
            NewAcct_EL.Currency = NewAcct.Currency;
            NewAcct_EL.Name = NewAcct.Name;
            NewAcct_EL.Description = NewAcct.Description;
            NewAcct_EL.IBAN = NewAcct.IBAN;
            NewAcct_EL.OpenDate = NewAcct.OpenDate;
            NewAcct_EL.ReferenceACCT = NewAcct.ReferenceACCT;
            NewAcct_EL.ReferenceOrg = NewAcct.ReferenceOrg;
            NewAcct_EL.STATUS_ID = NewAcct.STATUS_ID;
            NewAcct_EL.ACCT_QTY = NewAcct.ACCT_QTY;
            NewAcct_EL.ACCT_AMT = NewAcct.ACCT_AMT;
            NewAcct_EL.ACCT_AVG = NewAcct.ACCT_AVG;
            NewAcct_EL.ACCT_P_L = 0;

            db.DEF_SHARE_ACCT.Add(NewAcct_EL);
            db.SaveChanges();

            return NewAcct.ACCT_NO;
        }
    }
}
