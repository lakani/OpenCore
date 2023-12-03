using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Data.Common;

namespace SIS.OpenCore.Server.Data.Context
{
    public static class DbContextExtensions2
    {
        /*
         * need
            Microsoft.EntityFrameworkCore
            Microsoft.EntityFrameworkCore.Relational
         */
        public static DataTable DataTable(this DbContext context,
               string sqlQuery, params DbParameter[] parameters)
        {
            DataTable dataTable = new DataTable();
            DbConnection connection = context.Database.GetDbConnection();
            DbProviderFactory dbFactory = DbProviderFactories.GetFactory(connection);
            using (var cmd = dbFactory.CreateCommand())
            {
                cmd.Connection = connection;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sqlQuery;
                if (parameters != null)
                {
                    foreach (var item in parameters)
                    {
                        cmd.Parameters.Add(item);
                    }
                }
                using (DbDataAdapter adapter = dbFactory.CreateDataAdapter())
                {
                    adapter.SelectCommand = cmd;
                    adapter.Fill(dataTable);
                }
            }
            return dataTable;
        }
    }
}

