﻿using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Model;
//using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL.Objects;
using SIS.OpenCore.BL.Transactions;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL.RE.Helper;

namespace SIS.OpenCore.UnitTesting
{
    class NonBussinessMiscTests
    {
        [Test]
        public void Test_REDBUtils()
        {
            REDBUtils.Exists("LUT_CIF_TYPE", "Code", 1);
            REDBUtils.Exists("LUT_CIF_TYPE", "Code", 5);
            //REDBUtils.Exists("LUT_CIF_TYPE", "Code", ((DEF_CIF)inputOne).CIF_TYPE);
        }

        
        [Test]
        public void Test_Cast()
        {
            DEF_CK_ACCT_ACCT_STRUCT ACCTS = new DEF_CK_ACCT_ACCT_STRUCT();
            DEF_CK_ACCT_ACCT_STRUCT ModelACCTS;

            ACCTS.AccountCode = "1";
            ACCTS.AccountStructID = 1;
            ACCTS.GLCategory = 1;
            ACCTS.GLComments = "ACCTS.GLComments";
            ACCTS.GLNum = "12345";

            ModelACCTS = new DEF_CK_ACCT_ACCT_STRUCT();

            ModelACCTS = ACCTS as DEF_CK_ACCT_ACCT_STRUCT;


            ModelACCTS.GLComments = "After Casting";
            ACCTS = ModelACCTS;
        }

        [Test]
        public void TestAccountClassSetup()
        {
            List<DEF_ACCT_CLASS_ACCT_STRUCT> ACCTS = new List<DEF_ACCT_CLASS_ACCT_STRUCT>();
            ACCTS.Add(new DEF_ACCT_CLASS_ACCT_STRUCT
            {
                GLNum = "2-01-02-0000-00-00-00-0000-1-000001",
                GLCategory = 1
            });

            ACCTS.Add(new DEF_ACCT_CLASS_ACCT_STRUCT
            {
                GLNum = "2-01-02-0000-00-00-00-0000-1-000002",
                GLCategory = 2
            });


            AccountClass.Add(new DateTime(2020, 1, 1),
            1, //Company
            "CK", // Account Type)
            "EGP CK Account Class", //Name
            "EGP", // Currency
            "", //Ref
            ACCTS.ToArray());

        }

        [Test]
        public void TestStringFormat()
        {
            string str = "Nature";
            byte Nature = 1;
            string sNature = String.Format("{0, 0:D2}", Nature);
            string sRes = str.Replace("Nature", sNature);

            str = sRes;


        }

    }
}
