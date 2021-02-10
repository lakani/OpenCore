using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.DAL.Context;

namespace SIS.OpenCore.BL.RE.Helper
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

        public static bool Exists(string table, string ID, string value)
        {
            string stSQL;
            var context = new OpenCoreContext();

            //select ID from DEF_CIF WHERE ID = 1203
            stSQL = "select " + ID + " from " + table + " WHERE " + ID + " = " + value;
            //context.Database.ExecuteSqlInterpolatedAsync()
            //await context.SqlQueryAsync(stSQL);

            return true;
        }
    }
}
