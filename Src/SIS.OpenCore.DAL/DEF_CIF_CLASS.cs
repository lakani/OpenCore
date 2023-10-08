using System;
using System.Linq;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.Shared.Model;

namespace SIS.OpenCore.DAL
{
    public partial class DEF_CIF_CLASSDAL
    {
        public static string GetMaxCodePerCompany(short nCompanyNo)
        {
            OpenCoreContext db = new OpenCoreContext();
            /*(string sCode =  (from c in db.DEF_CIF_CLASS
                            where c.CompanyNo == nCompanyNo
                            select c.Code).Max(); */
            string sCode = (from c in db.DEF_CIF_CLASS
                            select c.Code).Max();

            if (string.IsNullOrEmpty(sCode))
                return string.Empty;
            return (sCode);
        }

        public static bool ValidateExists(string sCIFClassCode, short nCompanyNo)
        {
            OpenCoreContext db = new OpenCoreContext();
            string sCode = (from c in db.DEF_CIF_CLASS
                            where c.CompanyNo == nCompanyNo && c.Code == sCIFClassCode
                            select c.Code).FirstOrDefault();
            if (string.IsNullOrEmpty(sCode))
                return false;
            return true;
        }

        static public int Add_CIF_CLASS(DEF_CIF_CLASS newCIF_CLASSObj)
        {
            object CIFLock = new object();
            OpenCoreContext db = new OpenCoreContext();


            db.DEF_CIF_CLASS.Add(newCIF_CLASSObj);
            return db.SaveChanges();
        }

    }
}
