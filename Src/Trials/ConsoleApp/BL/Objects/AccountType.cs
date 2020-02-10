using System.Linq;
using System;
using SIS.OpenCore.EL;



namespace SIS.OpenCore.BL.Objects
{
    public partial class AccountType
    {
        public static bool ValidateExists(string stAccountType)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.LUT_ACCT_TYPE
                        where c.Name == stAccountType
                        select c.Name).FirstOrDefault();
            if(false == String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}