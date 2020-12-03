using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.BL.Process;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;

namespace SIS.OpenCore.BL.Objects
{
    public partial class ShareAccount
    {
        static protected byte _SHARE_ACCOUNT_NUM_FORMAT_LENGTH = 15;
        static protected string _SHARE_ACCOUNT_NUM_FORMAT = "000000000000000";

        public static string Create(DEF_SHARE_ACCT NewAcct)
        {
            return "0001";
        }
    }
}
