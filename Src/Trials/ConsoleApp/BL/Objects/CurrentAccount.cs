using System.Linq;
using System;
using SIS.OpenCore.Model;
using SIS.OpenCore.EL;



namespace SIS.OpenCore.BL.Objects
{
    public partial class CurrentAccount
    {
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

        public static string Add(SIS.OpenCore.Model.DEF_CK_ACCT NewAcctMode, SIS.OpenCore.Model.DEF_ACCT_CLASS_ACCT_STRUCT NewAcctStruct)
        {
            //needs to do the validation over here
            return "";
        }
    }
}