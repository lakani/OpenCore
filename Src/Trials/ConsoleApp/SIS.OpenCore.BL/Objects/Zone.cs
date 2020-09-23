using System.Linq;
using System;
using SIS.OpenCore.DAL;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL.Context;

namespace SIS.OpenCore.BL.Objects
{
    public partial class Zone
    {
        public static bool ValidateExists(byte nZone)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.DEF_Zone
                        where c.ID == nZone
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}