using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL.Context;

namespace SIS.OpenCore.DAL // Check the correct table attributes
{
    public partial class CurrentAccount
    {
        public static DEF_CK_ACCT[] List(string CIF_NO, string ISO, short cRecordsPerPage)
        {
            OpenCoreContext db = new OpenCoreContext();

            var Query = from a in db.DEF_CK_ACCT
                        where a.CIF_NO == CIF_NO && a.STATUS == 1 && a.ACCT_TYPE == "CK"
                        select a;

            if (false == String.IsNullOrEmpty(ISO))
                Query = Query.Where(a => a.Currency == ISO);

            return Query.Take(cRecordsPerPage).ToArray();
        }
    }
}
