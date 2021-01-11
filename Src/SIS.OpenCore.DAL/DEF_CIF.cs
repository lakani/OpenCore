using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;

namespace SIS.OpenCore.DAL // Check the correct table attributes
{
    public partial class Cif
    {
        public static DEF_CIF[] List(short cRecordsPerPage)
        {
            OpenCoreContext db = new OpenCoreContext();

            return ((from c in db.DEF_CIF
                     orderby c.CREATE_DT descending
                     select c).Take(cRecordsPerPage).ToArray());
        }

        public static DEF_CIF Get(string cifNO)
        {
            OpenCoreContext db = new OpenCoreContext();

            return  (from c in db.DEF_CIF
                    where c.CIF_NO == cifNO
                    select c).First();
        }
    }
}
