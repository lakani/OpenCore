using System.Linq;
using System;
using SIS.OpenCore.EL;

namespace SIS.OpenCore.BL.Objects
{
    public partial class Unit
    {
        public static bool ValidateExists(byte nUnit)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Unit
            var Ret =   (from c in db.DEF_Unit
                        where c.ID == nUnit
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}