using System.Linq;
using System;
using SIS.OpenCore.EL;


namespace SIS.OpenCore.BL.Objects
{
    public partial class AccountClass
    {
        static protected byte   _ACCOUNT_CLASS_CODE_FORMAT_LENGTH = 5;
        static protected string _ACCOUNT_CLASS_CODE_FORMAT = "00000";
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

        static protected string GenerateNewCode(string stAcctClassCode)
        {
            short nAcctClassCode = 0;
            string sReturn = string.Empty;
            
            // stAcctClassCode is provided or not
            if(string.IsNullOrEmpty(stAcctClassCode)) 
            {
                stAcctClassCode = GetMaxCode();
                if(true == string.IsNullOrEmpty(stAcctClassCode))
                     stAcctClassCode = _ACCOUNT_CLASS_CODE_FORMAT;
                nAcctClassCode = (short)short.Parse(stAcctClassCode);
                nAcctClassCode ++;
                sReturn = _ACCOUNT_CLASS_CODE_FORMAT + nAcctClassCode.ToString();
                int cToRemove = sReturn.Length - _ACCOUNT_CLASS_CODE_FORMAT_LENGTH;
                sReturn = sReturn.Remove(0,cToRemove);
            }
            else
            {
                if(stAcctClassCode.Length > _ACCOUNT_CLASS_CODE_FORMAT_LENGTH)
                    sReturn = string.Empty; // ERROR
                else
                {
                    sReturn = _ACCOUNT_CLASS_CODE_FORMAT + nAcctClassCode.ToString();
                    int cToRemove = sReturn.Length - _ACCOUNT_CLASS_CODE_FORMAT_LENGTH;
                    sReturn = sReturn.Remove(0,cToRemove);
                }
            }

            return stAcctClassCode;
        }

        static public string GetMaxCode()
        {
            OpenCoreContext db = new OpenCoreContext();
            string stMaxCode = (from r in db.DEF_ACCT_CLASS
                                select r.Code).Max();
            return stMaxCode;

        }

        static public string Add (
            DateTime    dtEFFECTIVE_DT,
            short       nCompanyNo,
            string      stAccountType,
            string      stName,
            string      stCurrency,
            string      stREFERENCE,
            string      stCode = "")
        {
            object CIFLock = new object();
            OpenCoreContext db = new OpenCoreContext();
            DEF_ACCT_CLASS  newAcctClass = new DEF_ACCT_CLASS();

            // check Company
            if(false == Company.ValidateExists(nCompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");
            
            if(false == AccountType.ValidateExists(stAccountType))
                throw new ArgumentOutOfRangeException("AccountType", "Account Type doesn't Exists");

            if(false == Currency.ValidateExists(stCurrency))
                throw new ArgumentOutOfRangeException("Currency", "Currency doesn't Exists");

            stCode = GenerateNewCode(stCode);
            if(true == string.IsNullOrEmpty(stCode))
                throw new ArgumentOutOfRangeException("Code", "Invalid Account Class Code");

            if(true == ValidateExists(stCode))
                throw new Exception("Account Class Code Already Exists");

            newAcctClass.Code = stCode;
            newAcctClass.CompanyNo = nCompanyNo;
            newAcctClass.EFFECTIVE_DT = dtEFFECTIVE_DT;
            newAcctClass.Name = stName;
            newAcctClass.Type = stAccountType;
            newAcctClass.REFERENCE = stREFERENCE;

            db.DEF_ACCT_CLASS.Add(newAcctClass);
            db.SaveChanges();

            return stCode;
        }
                
    }
}