using System.Linq;
using System;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;



namespace SIS.OpenCore.BL.Objects
{
    public partial class CIFCompany
    {
        public static bool ValidateExists(short nCompanyNo, string CIF_NO)
        {
            OpenCoreContext db = new OpenCoreContext();

            int Ret =   (from c in db.DEF_CIF_Company
                        where c.Company_ID == nCompanyNo && c.CIF_NO == CIF_NO
                        select c.DEF_CIF_Company_ID).Count();
            if(Ret == 0)
                return false;
            return true;
        }

        public static int AddCompany(short nCompanyNo, string CIF_NO)
        {
            OpenCoreContext db = new OpenCoreContext();
            var NewObject = new DEF_CIF_Company();
            
            NewObject.CIF_NO = CIF_NO;
            NewObject.Company_ID = nCompanyNo;

            db.DEF_CIF_Company.Add(NewObject);
            db.SaveChanges();

            return NewObject.DEF_CIF_Company_ID;
        }
    }
}