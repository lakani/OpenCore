﻿using System;
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
            testReverse();
            return;

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
            string.Empty,
            "01-01-01-01-01-01-000010"
            ); // Posting Level

            //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
            Console.WriteLine("Hello World!");
        }

        static void testReverse()
        {
            TRAN_POST_AE.Reverse(new Guid("F4B777D5-9033-42A2-BB65-147D3C1701A0"));
        }

        static void TestPostAE()
        {
            List<TRAN_POST_AE_TYPE_PARAM> ARR = new List<TRAN_POST_AE_TYPE_PARAM>();

            ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "CR" , Acct_No = "01-01-01-01-01-01-00010", GL = true, 
                                Acct_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });
            ARR.Add (new TRAN_POST_AE_TYPE_PARAM{ Acct_CR_DR = "DR" , Acct_No = "01-01-01-01-01-01-00002", GL = true, 
                                Acct_Amt = 150000, Acct_Curr="EGP", Acct_Description= "Cash Deposit", EffDt=DateTime.Today });


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
            
        }
    }
}