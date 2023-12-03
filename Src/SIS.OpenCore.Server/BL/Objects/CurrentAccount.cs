using System.Linq;
using System;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Server.BL;
using SIS.OpenCore.Server.Data.Context;
using DAL = SIS.OpenCore.Server.Data;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;


namespace SIS.OpenCore.Server.BL.Objects
{
    public partial class CurrentAccount
    {

        static protected short   _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH = 15;
        static protected string _CURRENT_ACCOUNT_NUM_FORMAT = "000000000000000";

        public static bool SearchRegardlessStatus(string stAcctNo)
        {
            OpenCoreContext db = new OpenCoreContext();
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
            OpenCoreContext db = new OpenCoreContext();
            var Ret =   (from   c in db.DEF_CK_ACCT
                        where   c.ACCT_NO == stAcctNo && c.STATUS == 1
                        select  c.ACCT_NO).FirstOrDefault();

            if (true == string.IsNullOrEmpty(Ret))
                return false;
            if(Ret != stAcctNo)
                return false;
            return true;
        }

        public static DEF_CK_ACCT GetAccountInfo(string stAcctNo)
        {
            OpenCoreContext db = new OpenCoreContext();
            var Ret =   (from   c in db.DEF_CK_ACCT
                        where   c.ACCT_NO == stAcctNo && c.STATUS == 1
                        select  c).FirstOrDefault();

            return Ret;
        }

        public static decimal GetLastBalance(string Acct_No, string Acct_Curr)
        {
            OpenCoreContext  db = new OpenCoreContext();
            //decimal?            BalanceAfter = 0 ;

            var BalanceAfter =  ((from l in db.TRN_LEGS
                                where   l.GL == false && l.STATUS_ID == 1 && 
                                    l.Acct_No == Acct_No && l.Acct_Curr == Acct_Curr 
                                orderby l.EffDt descending , l.CREATE_DT descending, 
                                    l.TRN_LEGS_ID descending, l.Sequence descending
                                select  l.Balance_After).FirstOrDefault());

            if(BalanceAfter == null)
                BalanceAfter = 0;

            return (decimal)BalanceAfter;
        }

        
        public static string Add(DEF_CK_ACCT NewAcct, DEF_CK_ACCT_ACCT_STRUCT [] NewAcctStruct)
        {
            OpenCoreContext db = new OpenCoreContext();
            DEF_CK_ACCT  newAcctEL = new DEF_CK_ACCT();
                                  
                        
            // if(false == AccountClass.ValidateExists(NewAcct.ACCT_CLASS))
            //     throw new ArgumentOutOfRangeException("ACCT_CLASS", "Account class doesn't Exists");

            foreach(DEF_CK_ACCT_ACCT_STRUCT ACCT_STRUCT in NewAcctStruct)
            {
                //GLNum, short GLCategory , string stCurrency)   
                if(false == AccountClassAccountingStructure.ValidateExists(ACCT_STRUCT.GLNum, ACCT_STRUCT.GLCategory, NewAcct.Currency))
                    throw new ArgumentOutOfRangeException("ACCT_STRUCT", "Account class doesn't Exists");
            }

            //NewAcct.ACCT_NO = GenerateNewACCT_NO(NewAcct.ACCT_NO);
            if(true == string.IsNullOrEmpty(NewAcct.ACCT_NO))
                throw new ArgumentOutOfRangeException("ACCT_NO", "Invalid Account Number");

            newAcctEL.ACCT_NO = NewAcct.ACCT_NO;
            newAcctEL.ACCT_CLASS_ID = NewAcct.ACCT_CLASS_ID;
            newAcctEL.CIF_NO = NewAcct.CIF_NO;
            newAcctEL.CompanyID = NewAcct.CompanyID;
            newAcctEL.Currency = NewAcct.Currency;
            newAcctEL.Description = NewAcct.Description;
            newAcctEL.IBAN = NewAcct.IBAN;
            newAcctEL.OpenDate = NewAcct.OpenDate;
            newAcctEL.ReferenceACCT = NewAcct.ReferenceACCT;
            newAcctEL.ReferenceOrg = NewAcct.ReferenceOrg;
            newAcctEL.STATUS = 1;
            newAcctEL.Title = NewAcct.Title;

            db.DEF_CK_ACCT.Add(newAcctEL);
            db.SaveChanges();   

            foreach(DEF_CK_ACCT_ACCT_STRUCT ACCT_STRUCT in NewAcctStruct)
            {
                DEF_CK_ACCT_ACCT_STRUCT ACCT_STRUCT_EL = new DEF_CK_ACCT_ACCT_STRUCT();

                ACCT_STRUCT_EL.AccountCode = NewAcct.ACCT_NO;
                ACCT_STRUCT_EL.GLCategory = ACCT_STRUCT.GLCategory;
                ACCT_STRUCT_EL.GLComments = ACCT_STRUCT.GLComments;
                ACCT_STRUCT_EL.GLNum = ACCT_STRUCT.GLNum;

                db.DEF_CK_ACCT_ACCT_STRUCT.Add(ACCT_STRUCT_EL);
                db.SaveChanges();
            }
            
            return newAcctEL.ACCT_NO;
        }

        

        static public DEF_CK_ACCT_ACCT_STRUCT [] GetAccountingStruct(string stACCT_NO)
        {
            OpenCoreContext db = new OpenCoreContext();
            DEF_CK_ACCT_ACCT_STRUCT[] AcctStruct =   (from r in db.DEF_CK_ACCT_ACCT_STRUCT
                                                        where r.AccountCode == stACCT_NO
                                                        select r ).ToArray();
            return AcctStruct;
        }

        static public string GetPrincipleGLForAccount(string stACCT_NO)
        {
            DEF_CK_ACCT_ACCT_STRUCT [] AcctStruct = GetAccountingStruct(stACCT_NO);
            string PrincipleGL =    (from g in AcctStruct
                                    where g.GLCategory == 1
                                    orderby g.AccountStructID descending
                                    select g.GLNum).FirstOrDefault();
                        
            return PrincipleGL;
        }



        
    }
}