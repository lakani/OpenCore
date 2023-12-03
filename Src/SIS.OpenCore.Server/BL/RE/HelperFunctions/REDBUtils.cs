using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Server.Data;


namespace SIS.OpenCore.Server.BL.RE.Helper
{
    public static class REDBUtils
    {
        public static bool CheckContains(string check, string valList)
        {
            if (String.IsNullOrEmpty(check) || String.IsNullOrEmpty(valList))
                return false;

            var list = valList.Split(',').ToList();
            return list.Contains(check);
        }

        public static bool Exists(string table, string ID, short? value)
        {
            if (value.HasValue)
                return REDBUtils.Exists(table, ID, (value.Value).ToString());
            else
                return false;
        }

        public static bool Exists(string table, string ID, string value)
        {
            return DBUtilities.Exists(table, ID, value);
        }
    }
}
