using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model;
//using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.Server.BL.Objects;


namespace SIS.OpenCore.UnitTesting
{
    class CurrentAccountTests
    {
        [Test]
        public void CurrentAccount_Create_Test()
        {

            //CurrentAccount.Add()

            List<DEF_CK_ACCT_ACCT_STRUCT> ACCTS = new List<DEF_CK_ACCT_ACCT_STRUCT>();

            ACCTS.Add(new DEF_CK_ACCT_ACCT_STRUCT
            {
                GLNum = "2-01-02-0000-00-00-00-0000-1-000032",
                GLCategory = 1
            });

            ACCTS.Add(new DEF_CK_ACCT_ACCT_STRUCT
            {
                GLNum = "2-01-02-0000-00-00-00-0000-1-000032",
                GLCategory = 2
            });


            CurrentAccount.Add(
                new DEF_CK_ACCT
                {
                    OpenDate = new DateTime(2020, 1, 1),
                    CompanyNo = 2, //Company
                    ACCT_TYPE = "CK", // Account Type)
                    ACCT_CLASS = "00001",
                    Currency = "EGP",       // Currency
                    CIF_NO = "000000001"
                }, // CIF    
                        ACCTS.ToArray());

        }
    }
}
