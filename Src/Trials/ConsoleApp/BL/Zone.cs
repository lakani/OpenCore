using System.Linq;
using System;
//using SIS.OpenCore.EL;

namespace SIS.OpenCore.BL
{
    public partial class Zone
    {
        public static bool ValidateExists(byte nZone)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.DefZone
                        where c.Id == nZone
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}