using System;
using System.Collections.Generic;
//using SIS.OpenCore.EL;
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
             TestPostAE();
             return;

            TestGLCreate();
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
            "",
            "01-01-01-01-01-01-000010"
            ); // Posting Level

            //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
            Console.WriteLine("Hello World!");
        }

        static void TestPostAE()
        {
            List<TRAN_POST_AE_TYPE_PARAM> ARR = new List<TRAN_POST_AE_TYPE_PARAM>();

             ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "01-01-01-01-01-01-00010", GL = true, 
                                Acct_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-00002", GL = true, 
                                Acct_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });


            TRAN_POST_AE.Post(ARR.ToArray());

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
                    "",
                    ""
                    ); // Posting Level
            }
            
        }
    }
}
