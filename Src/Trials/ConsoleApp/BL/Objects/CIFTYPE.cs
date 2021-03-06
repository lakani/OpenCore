using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL.Objects
{
    public partial class CifTYPE
    {
        public static bool ValidateExists(short TypeCode)
        {
            OpenCoreContext db = new OpenCoreContext();
            var Ret =   (from   t in db.LUT_CIF_TYPE
                        where   t.Code == TypeCode
                        select  t.Code).FirstOrDefault();

            if(Ret == 0)
                return false;  
            return true;
        }
    }
}
