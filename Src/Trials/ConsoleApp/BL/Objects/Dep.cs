using System.Linq;
using System;
using SIS.OpenCore.EL;

namespace SIS.OpenCore.BL.Objects
{
    public partial class Dep
    {
        public static bool ValidateExists(byte nDep)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Dep
            var Ret =   (from c in db.DEF_Dep
                        where c.ID == nDep
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}