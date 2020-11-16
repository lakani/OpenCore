using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Model;
//using SIS.OpenCore.DAL.Context;
using BLO = SIS.OpenCore.BL.Objects ;
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
            newAcct.CloseDate = new DateTime(2020, 12, 30);
            newAcct.CompanyNo = 1;
            newAcct.CreateDate = new DateTime(2020, 1, 1);
            newAcct.OpenDate = new DateTime(2020, 2, 1);
            newAcct.Principle = 1000000;
            newAcct.Currency = "EGP";
            newAcct.Rate = (decimal)5.5;
            
            BLO.FixedRateAccount.Create(newAcct, null);
        }

        public static void DeleteAccounts()
        {
            OpenCoreContext db = new OpenCoreContext();
            db.Database.ExecuteSqlCommand(new RawSqlString("truncate table  OpenCore..DEF_FIXRATE_ACCT"));
            db.Database.ExecuteSqlCommand( new RawSqlString("truncate table  OpenCore..DEF_FIXRATE_ACCT_DATES"));
        }

    }
}
