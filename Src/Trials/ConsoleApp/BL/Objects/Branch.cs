using System.Linq;
using System;
using SIS.OpenCore.EL;



namespace SIS.OpenCore.BL.Objects
{
    public partial class Branch
    {
        public static bool ValidateExists(short nBr)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.DEF_Branch
                        where c.ID == nBr
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }

        public static int Add_Branch(string stName, int nCompanyNo)
        {
            OpenCoreContext db = new OpenCoreContext();
            var newBr = new DEF_Branch() {
                    Name = stName,
                    CompanyNo = nCompanyNo
                };
            

            db.DEF_Branch.Add(newBr);
            db.SaveChanges();

            return newBr.ID;
        }
    }
}