using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.Shared.Objects;

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

        public static DEF_CIF[] List(DEF_CIF_PARAM param)
        {
            OpenCoreContext db = new OpenCoreContext();
            var Ret = from c in db.DEF_CIF
                      select c;

            ////orderby c.CREATE_DT descending

            if (false == String.IsNullOrEmpty(param.SearchKey))
                Ret.Where(c => c.SearchKey == param.SearchKey);

            if (false == String.IsNullOrEmpty(param.FirstName))
                Ret = Ret.Where(c => c.FirstName.Contains(param.FirstName));

            if (false == String.IsNullOrEmpty(param.LastName))
                Ret = Ret.Where(c => c.LastName.Contains(param.LastName));

            Ret = Ret.OrderByDescending(c => c.CREATE_DT);

            return Ret.Take(param.cRecords).ToArray();
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
