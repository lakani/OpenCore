using System;
using System.Collections.Generic;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL;
using SIS.OpenCore.BL.Objects;
using SIS.OpenCore.BL.Transactions;


namespace ConsoleApp
{
    class Program
    {
        
        //static void Add(string[] args)

        static void Main(string[] args)
        {
            //TestAccountClassSetup();
            //testCIF();
            //TestGLCreate();
            //testReverse();
            TestPostAE();
            return;

             
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
            List<DEF_ACCT_CLASS_ACCT_STRUCT> ACCTS = new List<DEF_ACCT_CLASS_ACCT_STRUCT>();
            ACCTS.Add(new DEF_ACCT_CLASS_ACCT_STRUCT{
                GLNum = "01-01-01-01-01-01-00001",
                GLCategory = 1
                });

            ACCTS.Add(new DEF_ACCT_CLASS_ACCT_STRUCT{
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
