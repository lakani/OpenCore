using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Model;
//using SIS.OpenCore.DAL.Context;
using BLO = SIS.OpenCore.BL;
using SIS.OpenCore.BL.Transactions;
using SIS.OpenCore.DAL.Context;
using Microsoft.EntityFrameworkCore;

namespace SIS.OpenCore.UnitTesting
{
    class FixedRateAccount
    {
        [Test]
        public void FixedRateAccount_Create_BasicCase()
        {
            DEF_FIXRATE_ACCT newAcct = new DEF_FIXRATE_ACCT();

            DeleteAccounts();

            newAcct.CIF_NO = "000000001";
            //newAcct.ACCT_CLASS = "0001"; // TODO : not yet
            //newAcct.ACCT_TYPE = ""; // TODO : not yet
            //newAcct.AccrualBasis = ""; // TODO : not yet
            newAcct.CompanyNo = 1;
            newAcct.CreateDate = new DateTime(2020, 11, 1);
            newAcct.OpenDate = new DateTime(2020, 11, 1);
            newAcct.CloseDate = new DateTime(2020, 11, 25);
            newAcct.Principle = 1000000;
            newAcct.Currency = "EGP";
            newAcct.Rate = (decimal)5.5;
            
            string sAcctNo = BLO.Objects.FixedRateAccount.Create(newAcct, null);
            newAcct.CloseDate.AddDays(200);

            for (DateTime x= newAcct.OpenDate.AddDays(1); x<=newAcct.CloseDate; x=x.AddDays(1))
                BLO.Process.FixedRateAccountProc.InterestCalculationProcess(x);
            
        }

        public static void DeleteAccounts()
        {
            OpenCoreContext db = new OpenCoreContext();
            db.Database.ExecuteSqlRaw("truncate table  OpenCore..DEF_FIXRATE_ACCT");
            db.Database.ExecuteSqlRaw("truncate table  OpenCore..DEF_FIXRATE_ACCT_DATES");
            db.Database.ExecuteSqlRaw("truncate table OpenCore..PROC_FIXRATE_INTEREST");
        }

    }
}
