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
            GL.Add_GL(new DateTime(2020,1,1), 1, 5,1,1,1,1,1,"EGP", 1);

            //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
            Console.WriteLine("Hello World!");
        }
    }
}
