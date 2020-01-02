using System;
using System.Collections.Generic;
//using SIS.OpenCore.EL;
using SIS.OpenCore.BL;


namespace ConsoleApp
{
    class Program
    {
        
        //static void Add(string[] args)

        static void Main(string[] args)
        {
            GL.fn_String_ParseGL("01-01-01-01-01-01-00001");
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
            "01-01-01-01-01-01-00010"
            ); // Posting Level

            //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
            Console.WriteLine("Hello World!");
        }
    }
}
