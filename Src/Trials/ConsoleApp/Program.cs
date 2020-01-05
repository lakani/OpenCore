using System;
using System.Collections.Generic;
//using SIS.OpenCore.EL;
using SIS.OpenCore.BL;
using SIS.OpenCore.BL.Objects;


namespace ConsoleApp
{
    class Program
    {
        
        //static void Add(string[] args)

        static void Main(string[] args)
        {
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
