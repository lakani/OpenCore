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
        public void Test_fn_GetGLInfo_29()
        {
            OpenCoreContext db = new OpenCoreContext();
            var GLs = (from g in db.VW_DEF_GL select g).ToArray();
            //var GLs =   from g in db.VW_DEF_GL
            //          select g.CURR , g.DepNo , g.GL;



            //foreach(VW_DEF_GL GLRec in GLs)
            for (int nLoop = 0; nLoop < GLs.Length; nLoop++)
            {
                VW_DEF_GL GLRec = GLs[nLoop];
                //foreach(VW_DEF_GL GLRec in GLs)

                DEF_GL _GL = GL.fn_GetGLInfo(GLRec.GL, GLRec.CURR);

                if (_GL == null)
                    Assert.Fail("NULL for GL" + GLRec.GL);

                if (_GL.CURR != GLRec.CURR)
                    Assert.Fail("_GL.CURR != GLRec.CURR");

                if (_GL.BranchNo != GLRec.BranchNo)
                    Assert.Fail("_GL.BranchNo != GLRec.BranchNo");

                if (_GL.CompanyNo != GLRec.CompanyNo)
                    Assert.Fail("_GL.CompanyNo != GLRec.CompanyNo");

                if (_GL.CURR != GLRec.CURR)
                    Assert.Fail("_GL.CURR != GLRec.CURR");

                if (_GL.DepNo != GLRec.DepNo)
                    Assert.Fail("_GL.DepNo != GLRec.DepNo");

                if (_GL.LedgerNO != GLRec.LedgerNO)
                    Assert.Fail("_GL.LedgerNO != GLRec.LedgerNO");

                if (_GL.Nature != GLRec.Nature)
                    Assert.Fail("_GL.Nature != GLRec.Nature");

                if (_GL.PostingLevel != GLRec.PostingLevel)
                    Assert.Fail("_GL.PostingLevel != GLRec.PostingLevel");

                if (_GL.SectorNo != GLRec.SectorNo)
                    Assert.Fail("_GL.SectorNo != GLRec.SectorNo");

                //if(_GL.TotallingGL != GLRec.TotallingGL)
                //  Assert.Fail("_GL.TotallingGL != GLRec.TotallingGL");

                if (_GL.UnitNO != GLRec.UnitNO)
                    Assert.Fail("_GL.UnitNO != GLRec.UnitNO");

                if (_GL.Zone != GLRec.Zone)
                    Assert.Fail("_GL.Zone != GLRec.Zone");
            }

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