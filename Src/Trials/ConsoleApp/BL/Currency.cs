using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.EL;


namespace SIS.OpenCore.BL
{
    public partial class Currency
    {
        public static bool ValidateExists(string stISO)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Currency
            // select ISOCode from DEF_Currency where ISOCode = 'EGP'
            var Ret =   (from c in db.DEF_Currency
                        where c.ISOCode == stISO
                        select c.ISOCode).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}
            
         