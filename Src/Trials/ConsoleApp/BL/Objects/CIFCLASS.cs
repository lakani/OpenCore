using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL.Objects
{
    public partial class CifClass
    {
        protected const byte    _CIF_Class_Format_Length = 4;
        protected const string  _CIF_Class_Format = "0000";

        static public string GetMaxCodePerCompany(short nCompanyNo)
        {
            OpenCoreContext db = new OpenCoreContext();
            /*(string sCode =  (from c in db.DEF_CIF_CLASS
                            where c.CompanyNo == nCompanyNo
                            select c.Code).Max(); */
            string sCode =  (from c in db.DEF_CIF_CLASS
                            select c.Code).Max(); 

            if(string.IsNullOrEmpty(sCode))
                return string.Empty;
            return (sCode);
        }

        public static bool ValidateExists(string sCIFClassCode, short nCompanyNo)
        {
            OpenCoreContext db = new OpenCoreContext();
            string sCode =  (from c in db.DEF_CIF_CLASS
                            where c.CompanyNo == nCompanyNo && c.Code == sCIFClassCode
                            select c.Code).FirstOrDefault();
            if(string.IsNullOrEmpty(sCode))
                return false;
            return true;
        }

        static public string GenerateNewCode (short nCompanyNo, string sCIFClassCode)
        {
            short nCIFClassCode = 0;
            string sReturn = string.Empty;
            // sCIFClassCode is provided or not
            if(string.IsNullOrEmpty(sCIFClassCode)) 
            {
                sCIFClassCode = GetMaxCodePerCompany(nCompanyNo);
                if(string.IsNullOrEmpty(sCIFClassCode))
                    sCIFClassCode = _CIF_Class_Format;
                nCIFClassCode = (short)short.Parse(sCIFClassCode);
                nCIFClassCode ++;
                sReturn = _CIF_Class_Format + nCIFClassCode.ToString();
                int cToRemove = sReturn.Length - _CIF_Class_Format_Length;
                sReturn = sReturn.Remove(0,cToRemove);
            }
            else
            {
                if(sCIFClassCode.Length > _CIF_Class_Format_Length)
                    sReturn = string.Empty; // ERROR
                else
                {
                    sReturn = _CIF_Class_Format + nCIFClassCode.ToString();
                    int cToRemove = sReturn.Length - _CIF_Class_Format_Length;
                    sReturn = sReturn.Remove(0,cToRemove);
                }
            }
            return sReturn;
        }
        
        static public string Add_CIF_CLASS (
            DateTime    dtEFFECTIVE_DT,
            short       nCompanyNo,
            byte        nCIF_TYPE,
            string      sCIFClassName,
            string      sCIFClassCode = "",
            string      sReference = ""
        )
        {
            object CIFLock = new object();
            OpenCoreContext db = new OpenCoreContext();
            DEF_CIF_CLASS   newCIF_CLASSObj = new DEF_CIF_CLASS();

            // check Company
            if(false == Company.ValidateExists(nCompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");

            if(false == CifTYPE.ValidateExists(nCIF_TYPE))
                throw new ArgumentOutOfRangeException("nCIF_TYPE", "CIF Type doesn't Exists");


            sCIFClassCode = GenerateNewCode(nCompanyNo, sCIFClassCode) ;
            if(string.IsNullOrEmpty(sCIFClassCode))
                return string.Empty;
            
            if(!ValidateExists(sCIFClassCode, nCompanyNo))
                return string.Empty;

            newCIF_CLASSObj.Code = sCIFClassCode;
            newCIF_CLASSObj.CompanyNo = nCompanyNo;
            newCIF_CLASSObj.EFFECTIVE_DT = dtEFFECTIVE_DT;
            newCIF_CLASSObj.Name = sCIFClassName;
            newCIF_CLASSObj.Type = nCIF_TYPE;
            newCIF_CLASSObj.REFERENCE = sReference;
            
            db.DEF_CIF_CLASS.Add (newCIF_CLASSObj);
            db.SaveChanges();
            
            return sCIFClassCode;
        }
    }
}
