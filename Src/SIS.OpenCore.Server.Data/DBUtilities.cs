using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Server.Data.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIS.OpenCore.Server.Data.TODO
{
    public partial class DBUtilities
    {
        // public static bool Exists(string table, string ID, string value)
        // {
        //     string stSQL;
        //     var context = new OpenCoreContext();

        //     //select ID from DEF_CIF WHERE ID = 1203
        //     stSQL = "SELECT COUNT(" + ID + ") AS CNT FROM [dbo].[" + table + "] WHERE " + ID + " = " + value + " ";
        //     //context.Database.ExecuteSqlInterpolatedAsync()
        //     //await context.SqlQueryAsync(stSQL);
        //     //context.SqlQueryAsync(stSQL);
        //     var Ret = context.DataTable(stSQL, null);
        //     //var Ret = context.Database.ex(stSQL);

        //     //if (Ret.  <= 0)
        //     //  return false;
        //     if((int)Ret.Rows[0][0] > 0)
        //         return true;
        //     return false;
        // }
    }
}
