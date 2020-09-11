using System;
using System.Linq;
using System.Collections.Generic;
using Model = SIS.OpenCore.Model;
using EL = SIS.OpenCore.Context;
using SIS.OpenCore.BL.Objects;
using SIS.OpenCore.BL.Transactions;


namespace ConsoleApp
{
    class Program
    {
        
        //static void Add(string[] args)

        static void Main(string[] args)
        {
            TestPostAE();
            //Test_Cast();
            //CurrentAccount_Create_Test();
            //Test_fn_GetGLInfo_29();
            //TestAccountClassSetup();
            //testCIF();
            //TestGLCreate();
            //testReverse();
            //TestPostAE();
            return;

            
            GL.fn_String_ParseGL("01-01-01-01-01-01-000001");

            GL.Add_GL(new DateTime(2020,1,1), // DATE
            1, // Company
            1, // Nature
            0, // Zone
            0, // Branch
            0, // Sector
            0, // Dep
            0, // Unit
            "EGP", // CURR
            1,
            string.Empty,
            "01-01-01-01-01-01-000010"
            ); // Posting Level

            //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
            Console.WriteLine("Hello World!");
        }

        static void TestAccountClassSetup()
        {
            List<Model.DEF_ACCT_CLASS_ACCT_STRUCT> ACCTS = new List<Model.DEF_ACCT_CLASS_ACCT_STRUCT>();
            ACCTS.Add(new Model.DEF_ACCT_CLASS_ACCT_STRUCT{
                GLNum = "01-01-01-01-01-01-00001",
                GLCategory = 1
                });

            ACCTS.Add(new Model.DEF_ACCT_CLASS_ACCT_STRUCT{
                GLNum = "01-01-01-01-01-01-00001",
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

        static void testCIF()
        {
            for (int x=0; x<10000; x++)
            {
                          //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
                          Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed", "", "", "","");
            }
            
            
            
        }

        static void testReverse()
        {
            TRAN_POST_AE.Reverse(new Guid("F4B777D5-9033-42A2-BB65-147D3C1701A0"));
        }

        static void TestPostAE()
        {
            List<TRAN_POST_AE_TYPE_PARAM> ARR = new List<TRAN_POST_AE_TYPE_PARAM>();

            ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "01-01-01-01-01-01-00010", GL = true, Category = 3,
                                Trn_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-00002", GL = true,  Category = 3,
                                Trn_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            
            ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-00010", GL = true, Category = 3,
                                Trn_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "000000000000001", GL = false,  Category = 3,
                                Trn_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });



            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "01-01-01-01-01-01-00001", GL = true, 
            //                     Acct_Amt = 18252, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-00010", GL = true, 
            //                     Acct_Amt = 18252, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "01-01-01-01-01-01-10430", GL = true, 
            //                     Acct_Amt = 78945, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            // ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-10440", GL = true, 
            //                     Acct_Amt = 78945, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });


            TRAN_POST_AE.Post(ARR.ToArray(), Guid.Empty);

        }

        static void Test_fn_GetGLInfo_29()
        {
            EL.OpenCoreContext db = new EL.OpenCoreContext();
            var GLs =   (from g in db.VW_DEF_GL select g).ToArray();
            //var GLs =   from g in db.VW_DEF_GL
              //          select g.CURR , g.DepNo , g.GL;
            
            

            //foreach(VW_DEF_GL GLRec in GLs)
            for(int nLoop=0; nLoop < GLs.Length; nLoop++)
            {
                EL.VW_DEF_GL GLRec = GLs[nLoop];
                //foreach(VW_DEF_GL GLRec in GLs)

                EL.DEF_GL _GL = GL.fn_GetGLInfo(GLRec.GL, GLRec.CURR);

                if(_GL == null)
                    throw new Exception("NULL for GL" + GLRec.GL);
                
                if(_GL.CURR != GLRec.CURR)
                    throw new Exception("_GL.CURR != GLRec.CURR");
                
                if(_GL.BranchNo != GLRec.BranchNo)
                    throw new Exception("_GL.BranchNo != GLRec.BranchNo");

                if(_GL.CompanyNo != GLRec.CompanyNo)
                    throw new Exception("_GL.CompanyNo != GLRec.CompanyNo");

                if(_GL.CURR != GLRec.CURR)
                    throw new Exception("_GL.CURR != GLRec.CURR");
                
                if(_GL.DepNo != GLRec.DepNo)
                    throw new Exception("_GL.DepNo != GLRec.DepNo");
                
                if(_GL.LedgerNO != GLRec.LedgerNO)
                    throw new Exception("_GL.LedgerNO != GLRec.LedgerNO");

                if(_GL.Nature != GLRec.Nature)
                    throw new Exception("_GL.Nature != GLRec.Nature");

                if(_GL.PostingLevel != GLRec.PostingLevel)
                    throw new Exception("_GL.PostingLevel != GLRec.PostingLevel");

                if(_GL.SectorNo != GLRec.SectorNo)
                    throw new Exception("_GL.SectorNo != GLRec.SectorNo");

                //if(_GL.TotallingGL != GLRec.TotallingGL)
                  //  throw new Exception("_GL.TotallingGL != GLRec.TotallingGL");

                if(_GL.UnitNO != GLRec.UnitNO)
                    throw new Exception("_GL.UnitNO != GLRec.UnitNO");
                
                if(_GL.Zone != GLRec.Zone)
                    throw new Exception("_GL.Zone != GLRec.Zone");


            }
            
        }

        static void Test_Cast()
        {
            EL.DEF_CK_ACCT_ACCT_STRUCT ACCTS = new EL.DEF_CK_ACCT_ACCT_STRUCT();
            Model.DEF_CK_ACCT_ACCT_STRUCT ModelACCTS ;

            ACCTS.AccountCode = "1";
            ACCTS.AccountStructID = 1;
            ACCTS.GLCategory = 1;
            ACCTS.GLComments = "ACCTS.GLComments";
            ACCTS.GLNum = "12345";

            ModelACCTS = new Model.DEF_CK_ACCT_ACCT_STRUCT();

            ModelACCTS = ACCTS as Model.DEF_CK_ACCT_ACCT_STRUCT;
            

            ModelACCTS.GLComments = "After Casting";
            ACCTS = ModelACCTS;
        }

        static void CurrentAccount_Create_Test()
        {
            
            //CurrentAccount.Add()

            List<Model.DEF_CK_ACCT_ACCT_STRUCT> ACCTS = new List<Model.DEF_CK_ACCT_ACCT_STRUCT>();

            ACCTS.Add(new Model.DEF_CK_ACCT_ACCT_STRUCT{
                GLNum = "01-01-01-01-01-01-00001",
                GLCategory = 1
                });

            ACCTS.Add(new Model.DEF_CK_ACCT_ACCT_STRUCT{
                GLNum = "01-01-01-01-01-01-00001",
                GLCategory = 2
                });


            CurrentAccount.Add(
                new Model.DEF_CK_ACCT  { 
                        OpenDate = new DateTime(2020, 1, 1),
                        CompanyNo = 1, //Company
                        ACCT_TYPE = "CK", // Account Type)
                        ACCT_CLASS = "00001",
                        Currency = "EGP",       // Currency
                        CIF_NO = "000000001"} , // CIF    
                        ACCTS.ToArray());

        }

        static void TestGLCreate()
        {
            Random random= new Random();

            for(int n=0; n<100; n++)
            {
                byte nNature = (byte)random.Next(1,6);
                Console.WriteLine("Nature = " + nNature.ToString());

                GL.Add_GL(
                    new DateTime(2020,1,1), // DATE
                    1, // Company
                    nNature, // Nature
                    0, // Zone
                    0, // Branch
                    0, // Sector
                    0, // Dep
                    0, // Unit
                    "EGP", // CURR
                    1,
                    string.Empty,
                    string.Empty
                    ); // Posting Level
            }

            GL.Add_GL(
                new DateTime(2020,1,1), // DATE
                1, // Company
                1, // Nature
                0, // Zone
                0, // Branch
                0, // Sector
                0, // Dep
                0, // Unit
                "EGP", // CURR
                1,
                "99999",
                string.Empty
                ); // Posting Level

            GL.Add_GL(
                new DateTime(2020,1,1), // DATE
                1, // Company
                2, // Nature
                0, // Zone
                0, // Branch
                0, // Sector
                0, // Dep
                0, // Unit
                "EGP", // CURR
                1,
                "99999",
                string.Empty
                ); // Posting Level



        }
    }
}
