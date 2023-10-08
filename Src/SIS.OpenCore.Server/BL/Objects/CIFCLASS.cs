using System.Linq;
using System;
using SIS.OpenCore.DAL;
using SIS.OpenCore.Shared.Model;
using System.Collections.Generic;
using SIS.OpenCore.Server.BL.RE;

namespace SIS.OpenCore.Server.BL.Objects
{
    public partial class CifClass
    {
        protected const short    _CIF_Class_Format_Length = 4;
        protected const string  _CIF_Class_Format = "0000";


        public static bool ValidateExists(string sCIFClassCode, short nCompanyNo)
        {
            return DEF_CIF_CLASSDAL.ValidateExists(sCIFClassCode, nCompanyNo);
        }

        static public string GenerateNewCode (short nCompanyNo, string sCIFClassCode)
        {
            short nCIFClassCode = 0;
            string sReturn = string.Empty;
            // sCIFClassCode is provided or not
            if(string.IsNullOrEmpty(sCIFClassCode)) 
            {
                sCIFClassCode = DEF_CIF_CLASSDAL.GetMaxCodePerCompany(nCompanyNo);
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
            short        nCIF_TYPE,
            string      sCIFClassName,
            string      sCIFClassCode = "",
            string      sReference = ""
        )
        {
            DEF_CIF_CLASS   newCIF_CLASSObj = new DEF_CIF_CLASS();

            newCIF_CLASSObj.Code = sCIFClassCode;
            newCIF_CLASSObj.CompanyNo = nCompanyNo;
            newCIF_CLASSObj.EFFECTIVE_DT = dtEFFECTIVE_DT;
            newCIF_CLASSObj.Name = sCIFClassName;
            newCIF_CLASSObj.Type = nCIF_TYPE;
            newCIF_CLASSObj.REFERENCE = sReference;

            SmartRulesEngine.Run("CIF_CLASS", "CIFCLASSPOST", newCIF_CLASSObj, null);

            // check Company
            //if (false == Company.ValidateExists(nCompanyNo))
            //    throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");

            //if(false == CifTYPE.ValidateExists(nCIF_TYPE))
            //    throw new ArgumentOutOfRangeException("nCIF_TYPE", "CIF Type doesn't Exists");

            sCIFClassCode = GenerateNewCode(nCompanyNo, sCIFClassCode) ;
            if(string.IsNullOrEmpty(sCIFClassCode))
                throw new ArgumentOutOfRangeException("sCIFClassCode", "Invalid CIF class Code");
            
            if(true == ValidateExists(sCIFClassCode, nCompanyNo))
                throw new Exception("sCIFClassCode Already Exists");

            newCIF_CLASSObj.Code = sCIFClassCode;

            if (-1 == DEF_CIF_CLASSDAL.Add_CIF_CLASS(newCIF_CLASSObj))
                return "";

            return sCIFClassCode;
        }
    }
}
