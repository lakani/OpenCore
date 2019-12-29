using System.Linq;
using System;
//using SIS.OpenCore.EL;



namespace SIS.OpenCore.BL
{
    public partial class Branch
    {
        public static bool ValidateExists(short nBr)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.DefBranch
                        where c.Id == nBr
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}