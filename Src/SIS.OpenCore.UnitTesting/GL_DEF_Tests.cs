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
    public class GL_DEF_Tests
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

                DEF_GL _GL = GL.GetGLInfo(GLRec.GL, GLRec.CURR);

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

                //if (_GL.LedgerNO != GLRec.LedgerNO)
                  //  Assert.Fail("_GL.LedgerNO != GLRec.LedgerNO");

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
        [TestCase("CompanyNo-PostingLevel-Nature-LedgerNo", "01-1-1-000001")]
        [TestCase("CompanyNo-PostingLevel-Nature-LedgerNo", "01-1-1-000020")]
        [TestCase("CompanyNo-PostingLevel-Nature-LedgerNo", "01-1-1-000000")]
        [TestCase("Nature-CompanyNo-PostingLevel-LedgerNo", "1-01-1-000001")]
        [TestCase("Nature-CompanyNo-BranchNo-PostingLevel-LedgerNo", "1-01-0750-1-000001")]
        public void TestParse(string sGLFormat, string sGL)
        {
            string stOldFormat;
            // save old and update GL format
            OpenCoreContext db = new OpenCoreContext();
            var Record =    (from r in db.Settings
                            orderby r.VerID descending
                            select r).First();
            stOldFormat = Record.GLFormat;
            Record.GLFormat = sGLFormat;
            db.SaveChanges();

            var dEF_GL = GL.fn_String_ParseGL(sGL);
            dEF_GL.EFFECTIVE_DT = DateTime.Now;

            // Save it again
            Record =    (from r in db.Settings
                        orderby r.VerID descending
                        select r).First();
            Record.GLFormat = stOldFormat;
            db.SaveChanges();
        }
        [Test]
        public void Test_GenerateGL()
        {
            short   CompanyNo       = 1;
            byte    NATURE          = 1;
            string  CURR            = "EGP";
            byte    nZone           = 1;
            short   BranchNo        = 0;
            byte    SectorNo        = 0;
            byte    DepNo           = 0;  
            byte    UNITNO          = 0;
            short   ProductNo       = 0;
            byte    POSTINGLEVEL    = 1;
            int     LEDGERNO        = 0;
            string sGL              = "";


            sGL = GL.GenerateGL(CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, POSTINGLEVEL, LEDGERNO); ;

        }

        [Test]
        public void Test_Simple_GLCreate()
        {
            short CompanyNo = 2;
            byte NATURE = 2;
            string CURR = "EGP";
            byte nZone = 1;
            short BranchNo = 0;
            byte SectorNo = 0;
            byte DepNo = 0;
            byte UNITNO = 0;
            short ProductNo = 0;
            byte POSTINGLEVEL = 1;
            int LEDGERNO = 0;
            string sGL = "";
            DateTime dt = new DateTime(2020, 1, 1); /* DATE*/

            for (int n = 0; n < 10; n++)
            {
                sGL = String.Empty;
                sGL = GL.Add_GL(dt, CompanyNo, NATURE, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, CURR, POSTINGLEVEL, LEDGERNO, sGL); ;
            }
        }


        [Test]
        public void TestGLCreate()
        {
            Random random = new Random();

            for (int n = 0; n < 100; n++)
            {
                byte nNature = (byte)random.Next(1, 6);
                Console.WriteLine("Nature = " + nNature.ToString());

                //GL.Add_GL(new DateTime(2020, 1, 1), /* DATE*/
                //            1, // Company
                //            nNature, // Nature
                //            0, // Zone
                //            0, // Branch
                //            0, // Sector
                //            0, // Dep
                //            0, // Unit
                //            0, // Product
                //            "EGP", // CURR
                //            1,
                //            string.Empty,
                //            string.Empty
                //            ); // Posting Level
            

            }

            //GL.Add_GL(
            //    new DateTime(2020, 1, 1), // DATE
            //    1, // Company
            //    1, // Nature
            //    0, // Zone
            //    0, // Branch
            //    0, // Sector
            //    0, // Dep
            //    0, // Unit
            //    0, // Product
            //    "EGP", // CURR
            //    1,
            //    "99999",
            //    string.Empty
            //    ); // Posting Level

            //GL.Add_GL(
            //    new DateTime(2020, 1, 1), // DATE
            //    1, // Company
            //    2, // Nature
            //    0, // Zone
            //    0, // Branch
            //    0, // Sector
            //    0, // Dep
            //    0, // Unit
            //    0, // Product
            //    "EGP", // CURR
            //    1,
            //    "99999",
            //    string.Empty
            //    ); // Posting Level
        }

    }
}