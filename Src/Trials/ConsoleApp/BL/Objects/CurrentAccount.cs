using System.Linq;
using System;
using MODEL = SIS.OpenCore.Model;
using EL = SIS.OpenCore.EL;



namespace SIS.OpenCore.BL.Objects
{
    public partial class CurrentAccount
    {
        public static bool SearchRegardlessStatus(string stAcctNo)
        {
            EL.OpenCoreContext db = new EL.OpenCoreContext();
            var Ret =   (from   c in db.DEF_CK_ACCT
                        where   c.ACCT_NO == stAcctNo
                        select  c.ACCT_NO).FirstOrDefault();

            if (true == string.IsNullOrEmpty(Ret))
                return false;
            if(Ret != stAcctNo)
                return false;
            return true;
        }

        public static bool Search(string stAcctNo)
        {
            EL.OpenCoreContext db = new EL.OpenCoreContext();
            var Ret =   (from   c in db.DEF_CK_ACCT
                        where   c.ACCT_NO == stAcctNo && c.STATUS == 1
                        select  c.ACCT_NO).FirstOrDefault();

            if (true == string.IsNullOrEmpty(Ret))
                return false;
            if(Ret != stAcctNo)
                return false;
            return true;
        }

        public static string Add(Model.DEF_CK_ACCT NewAcct, Model.DEF_ACCT_CLASS_ACCT_STRUCT [] NewAcctStruct)
        {
            //needs to do the validation over here

            // Validate on Company
            if(false == Company.ValidateExists(NewAcct.CompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");

            if(false == AccountType.ValidateExists(NewAcct.ACCT_TYPE))
                throw new ArgumentOutOfRangeException("AccountType", "Account Type doesn't Exists");

            if(false == Currency.ValidateExists(NewAcct.Currency))
                throw new ArgumentOutOfRangeException("Currency", "Currency doesn't Exists");
            
            if(false == AccountClass.ValidateExists(NewAcct.ACCT_CLASS))
                throw new ArgumentOutOfRangeException("ACCT_CLASS", "Account class doesn't Exists");

            foreach(Model.DEF_ACCT_CLASS_ACCT_STRUCT ACCT_STRUCT in NewAcctStruct)
            {
                //GLNum, short GLCategory , string stCurrency)   
                if(false == AccountClassAccountingStructure.ValidateExists(ACCT_STRUCT.GLNum, ACCT_STRUCT.GLCategory, NewAcct.Currency))
                    throw new ArgumentOutOfRangeException("ACCT_STRUCT", "Account class doesn't Exists");
            }

            NewAcct.ACCT_NO = GenerateNewACCT_NO(NewAcct.ACCT_NO);
            if(true == string.IsNullOrEmpty(NewAcct.ACCT_NO))
                throw new ArgumentOutOfRangeException("ACCT_NO", "Invalid Account Number");
            
            
                      


            return "";
        }

        static protected string GenerateNewACCT_NO(string ACCT_NO)
        {
            return "0000001";
        }
    }
}