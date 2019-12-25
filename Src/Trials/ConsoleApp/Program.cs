using System;
using System.Collections.Generic;
using ConsoleApp.EF;


namespace ConsoleApp
{
    class Program
    {
        
        //static void Add(string[] args)

        static void Main(string[] args)
        {
            DefCif cif = new DefCif();
            DefCif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
            Console.WriteLine("Hello World!");
        }
    }
}
