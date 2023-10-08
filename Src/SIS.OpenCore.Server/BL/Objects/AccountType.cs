using System.Linq;
using System;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;



namespace SIS.OpenCore.Server.BL.Objects
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
            if(true == String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}