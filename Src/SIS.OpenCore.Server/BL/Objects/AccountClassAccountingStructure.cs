using System.Linq;
using System;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Server.Data;
using SIS.OpenCore.Server.Data.Context;

namespace SIS.OpenCore.Server.BL.Objects
{
    public partial class AccountClassAccountingStructure
    {
        static public bool Add(DEF_ACCT_CLASS_ACCT_STRUCT []GLAccounts, string stAcctClsCode)
        {
            foreach(DEF_ACCT_CLASS_ACCT_STRUCT GLAccount in GLAccounts)
            {
                if(false == Add(GLAccount, stAcctClsCode))
                    throw new Exception("Failed to insert Accounting structure for Account Class");
            }

            return true;
        }

        static public bool Add(DEF_ACCT_CLASS_ACCT_STRUCT GLAccount, string stAcctClsCode)
        {
            // DeadCode
            // OpenCoreContext db = new OpenCoreContext();
            // DEF_ACCT_CLASS_ACCT_STRUCT  newAcctStruct = new DEF_ACCT_CLASS_ACCT_STRUCT();
            // int nReturn;

            // newAcctStruct = GLAccount;
            // newAcctStruct.AccountClassCode = stAcctClsCode;
            // db.DEF_ACCT_CLASS_ACCT_STRUCT.Add(newAcctStruct);
            // nReturn = db.SaveChanges();
            // if(nReturn<= 0)
            //     return false;

            return true;
        }

        static public bool ValidateExists(DEF_ACCT_CLASS_ACCT_STRUCT []GLAccounts, string stCurrency)
        {
            foreach(DEF_ACCT_CLASS_ACCT_STRUCT GLAccount in GLAccounts)
            {
                if(false == ValidateExists(GLAccount, stCurrency))
                    return false;
            }
            return true;
        }
        static public bool ValidateExists(DEF_ACCT_CLASS_ACCT_STRUCT GLAccount, string stCurrency)   
        {
            // Validate acct.GLNum
            // BUILD_ERR: 
            // if(null == GL.GetGLInfo(GLAccount.GLNum, stCurrency))
            //     return false;

            // Validate acct.GLCategory
            if(false == LUTGLAccountCategory.ValidateExists(GLAccount.GLCategory))
                return false;
            
            return true;
        }

        static public bool ValidateExists(string GLNum, short GLCategory , string stCurrency)   
        {
            // Validate acct.GLNum
            // BUILD_ERR: 
            // if(null == GL.GetGLInfo(GLNum, stCurrency))
            //     return false;

            // Validate acct.GLCategory
            if(false == LUTGLAccountCategory.ValidateExists(GLCategory))
                return false;
            return true;
        }
    }
}