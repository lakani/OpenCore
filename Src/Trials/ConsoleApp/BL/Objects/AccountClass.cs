using System.Linq;
using System;
using SIS.OpenCore.EL;


namespace SIS.OpenCore.BL.Objects
{
    public partial class AccountClass
    {
        static public bool ValidateExists(string stCode)
        {
            OpenCoreContext db = new OpenCoreContext();
            string Ret = string.Empty;

            Ret =   (from r in db.DEF_ACCT_CLASS
                    where r.Code == stCode
                    select r.Code).First();
            if( false == string.IsNullOrEmpty(Ret))
                return false;
            return true;
        }

        static protected string GenerateNewCode(string stClassCode)
        {
            short nCIFClassCode = 0;
            string sReturn = string.Empty;
            
            // sCIFClassCode is provided or not
            // if(string.IsNullOrEmpty(stClassCode)) 
            // {
            //     stClassCode = GetMaxCode();
            //     if(string.IsNullOrEmpty(sCIFClassCode))
            //         sCIFClassCode = _CIF_Class_Format;
            //     nCIFClassCode = (short)short.Parse(sCIFClassCode);
            //     nCIFClassCode ++;
            //     sReturn = _CIF_Class_Format + nCIFClassCode.ToString();
            //     int cToRemove = sReturn.Length - _CIF_Class_Format_Length;
            //     sReturn = sReturn.Remove(0,cToRemove);
            // }
            // else
            // {
            //     if(sCIFClassCode.Length > _CIF_Class_Format_Length)
            //         sReturn = string.Empty; // ERROR
            //     else
            //     {
            //         sReturn = _CIF_Class_Format + nCIFClassCode.ToString();
            //         int cToRemove = sReturn.Length - _CIF_Class_Format_Length;
            //         sReturn = sReturn.Remove(0,cToRemove);
            //     }
            // }

            return stClassCode;
        }

        static public string Add (
            DateTime    dtEFFECTIVE_DT,
            short       nCompanyNo,
            string      stAccountType,
            string      stName,
            string      stCode = "")
        {
            object CIFLock = new object();
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            if(false == Company.ValidateExists(nCompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");
            
            if(false == AccountType.ValidateExists(stAccountType))
                throw new ArgumentOutOfRangeException("AccountType", "Account Type doesn't Exists");

            

            

            return string.Empty;
        }
                
    }
}