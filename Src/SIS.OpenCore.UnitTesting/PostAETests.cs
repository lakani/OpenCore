using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Model;
//using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL.Objects;
using SIS.OpenCore.BL.Transactions;
using SIS.OpenCore.DAL.Context;

namespace SIS.OpenCore.UnitTesting
{
    public class PostAETests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void TestPostAE()
        {
            List<TRAN_POST_AE_TYPE_PARAM> ARR = new List<TRAN_POST_AE_TYPE_PARAM>();

            ARR.Add(new TRAN_POST_AE_TYPE_PARAM
            {
                Acct_CR_DR = "CR",
                Acct_No = "01-01-01-01-01-01-00010",
                GL = true,
                Category = 3,
                Trn_Amt = 150000,
                Acct_Curr = "EGP",
                Acct_Description = "Cash Deposit",
                EffDt = DateTime.Today
            });
            ARR.Add(new TRAN_POST_AE_TYPE_PARAM
            {
                Acct_CR_DR = "DR",
                Acct_No = "01-01-01-01-01-01-00002",
                GL = true,
                Category = 3,
                Trn_Amt = 150000,
                Acct_Curr = "EGP",
                Acct_Description = "Cash Deposit",
                EffDt = DateTime.Today
            });

            ARR.Add(new TRAN_POST_AE_TYPE_PARAM
            {
                Acct_CR_DR = "DR",
                Acct_No = "01-01-01-01-01-01-00010",
                GL = true,
                Category = 3,
                Trn_Amt = 150000,
                Acct_Curr = "EGP",
                Acct_Description = "Cash Deposit",
                EffDt = DateTime.Today
            });
            ARR.Add(new TRAN_POST_AE_TYPE_PARAM
            {
                Acct_CR_DR = "CR",
                Acct_No = "000000000000001",
                GL = false,
                Category = 3,
                Trn_Amt = 150000,
                Acct_Curr = "EGP",
                Acct_Description = "Cash Deposit",
                EffDt = DateTime.Today
            });



            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "01-01-01-01-01-01-00001", GL = true, 
            //                     Acct_Amt = 18252, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-00010", GL = true, 
            //                     Acct_Amt = 18252, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "01-01-01-01-01-01-10430", GL = true, 
            //                     Acct_Amt = 78945, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-10440", GL = true, 
            //                     Acct_Amt = 78945, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });


            var Ret = TRAN_POST_AE.Post(ARR.ToArray(), Guid.Empty);
            Guid RetGuid;
            if (Guid.TryParse(Ret.ToString(), out RetGuid) == false)
                Assert.Fail("TRAN_POST_AE.Post");

        }

        [TestCase("2D858C4B-6B16-4D33-ABC0-F67E365B0F0B")]
        public void testReverse(string Ref)
        {
            Guid RefGuid = new Guid(Ref);

            if(TRAN_POST_AE.ValidRef(RefGuid) == true)
                TRAN_POST_AE.Reverse(RefGuid);
        }

        [Test]
        public void CurrentAccount_Create_Test()
        {
            List<DEF_CK_ACCT_ACCT_STRUCT> ACCTS = new List<DEF_CK_ACCT_ACCT_STRUCT>();

            ACCTS.Add(new DEF_CK_ACCT_ACCT_STRUCT
            {
                GLNum = "01-01-01-01-01-01-00001",
                GLCategory = 1
            });

            ACCTS.Add(new DEF_CK_ACCT_ACCT_STRUCT
            {
                GLNum = "01-01-01-01-01-01-00001",
                GLCategory = 2
            });


            CurrentAccount.Add(
                new DEF_CK_ACCT
                {
                    OpenDate = new DateTime(2020, 1, 1),
                    CompanyNo = 1, //Company
                    ACCT_TYPE = "CK", // Account Type)
                    ACCT_CLASS = "00001",
                    Currency = "EGP",       // Currency
                    CIF_NO = "000000001"
                }, // CIF    
                        ACCTS.ToArray());
        }
    }
}