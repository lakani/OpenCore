using System.Linq;
using System;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;



namespace SIS.OpenCore.BL.Objects
{
    public partial class Company
    {
        public static bool ValidateExists(int nCompany)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.DEF_Company
                        where c.ID == nCompany
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}