using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Model;
//using SIS.OpenCore.DAL.Context;
using BAL = SIS.OpenCore.BL.Objects;
using SIS.OpenCore.BL.Transactions;
using SIS.OpenCore.DAL.Context;
using Microsoft.EntityFrameworkCore;



namespace SIS.OpenCore.UnitTesting
{
    class ShareAccount
    {
        public static void DeleteAccounts()
        {
            OpenCoreContext db = new OpenCoreContext();
            db.Database.ExecuteSqlRaw("truncate table  OpenCore..DEF_SHARE_ACCT");
            //db.Database.ExecuteSqlRaw("truncate table  OpenCore..DEF_FIXRATE_ACCT_DATES");
            //db.Database.ExecuteSqlRaw("truncate table OpenCore..PROC_FIXRATE_INTEREST");
        }

        [Test]
        public void ShareAccount_Create()
        {
            DeleteAccounts();

            DEF_SHARE_ACCT newAcct = new DEF_SHARE_ACCT();
            newAcct.ACCT_AMT = 100;
            newAcct.ACCT_AVG = 10;
            newAcct.ACCT_QTY = 100;
            newAcct.CIF_NO = "000000001";
            newAcct.CompanyNo = 1;
            newAcct.CSP_Code = "01"; ;
            newAcct.Currency = "EGP";
            newAcct.Name = "EGX30";
            newAcct.OpenDate = DateTime.Now;
            
            var ret = BAL.ShareAccount.Create(newAcct);
            if (string.IsNullOrEmpty(ret))
                throw new Exception("Failed to Create new Share Account");
            else
                newAcct.ACCT_NO = ret;

            var rF = BAL.ShareAccount.Find(new DEF_SHARE_ACCT {CIF_NO = newAcct.CIF_NO, Currency = newAcct.Currency, Name = newAcct.Name });
            if(rF == null)
                throw new Exception("Failed to Find the new Created new Share Account");

            if (rF.ACCT_NO != newAcct.ACCT_NO)
                throw new Exception("Failed to Create new Share Account");

        }
    }
}
