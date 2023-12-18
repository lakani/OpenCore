using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model;
//using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.BL.Objects;
using SIS.OpenCore.Server.BL.RE.Helper;

namespace SIS.OpenCore.UnitTesting
{
    class NonBussinessMiscTests
    {
        [Test]
        public void Test_REDBUtils()
        {
            // DeadCode :
            //REDBUtils.Exists("LUT_CIF_TYPE", "Code", 1);
            //REDBUtils.Exists("LUT_CIF_TYPE", "Code", 5);
            //REDBUtils.Exists("LUT_CIF_TYPE", "Code", ((CIF_DESC)inputOne).CIF_TYPE);
        }

        
        [Test]
        public void Test_Cast()
        {
            CIF_CK_ACCT_ACCT_STRUCT ACCTS = new CIF_CK_ACCT_ACCT_STRUCT();
            CIF_CK_ACCT_ACCT_STRUCT ModelACCTS;

            ACCTS.AccountCode = "1";
            ACCTS.AccountStructID = 1;
            ACCTS.GLCategory = 1;
            ACCTS.GLComments = "ACCTS.GLComments";
            ACCTS.GLNum = "12345";

            ModelACCTS = new CIF_CK_ACCT_ACCT_STRUCT();

            ModelACCTS = ACCTS as CIF_CK_ACCT_ACCT_STRUCT;


            ModelACCTS.GLComments = "After Casting";
            ACCTS = ModelACCTS;
        }

        [Test]
        public void TestAccountClassSetup()
        {
            List<CIF_ACCT_CLASS_ACCT_STRUCT> ACCTS = new List<CIF_ACCT_CLASS_ACCT_STRUCT>();
            ACCTS.Add(new CIF_ACCT_CLASS_ACCT_STRUCT
            {
                GLNum = "2-01-02-0000-00-00-00-0000-1-000001",
                GLCategory = 1
            });

            ACCTS.Add(new CIF_ACCT_CLASS_ACCT_STRUCT
            {
                GLNum = "2-01-02-0000-00-00-00-0000-1-000002",
                GLCategory = 2
            });


            // AccountClass.Add(new DateTime(2020, 1, 1),
            // 1, //Company
            // "CK", // Account Type)
            // "EGP CK Account Class", //Name
            // "EGP", // Currency
            // "", //Ref
            // ACCTS.ToArray());

        }

        [Test]
        public void TestStringFormat()
        {
            string str = "Nature";
            short Nature = 1;
            string sNature = String.Format("{0, 0:D2}", Nature);
            string sRes = str.Replace("Nature", sNature);

            str = sRes;


        }

    }
}
