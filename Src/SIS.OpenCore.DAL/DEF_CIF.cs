using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.Shared.Model.Objects.CIF;

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

        // BUILD_ERR : the below
        // public static DEF_CIF[] List(DEF_CIF_PARAM param)
        // {
        //     OpenCoreContext db = new OpenCoreContext();
        //     var Ret = from c in db.DEF_CIF
        //               select c;

        //     ////orderby c.CREATE_DT descending
            
        //     if (false == String.IsNullOrEmpty(param.Name))
        //         Ret = Ret.Where(c =>    c.SearchKey.Contains(param.Name) || c.FirstName.Contains(param.Name) ||
        //                                 c.LastName.Contains(param.Name) || c.FamilyName.Contains(param.Name));

        //     if (false == String.IsNullOrEmpty(param.SearchKey))
        //         Ret = Ret.Where(c => c.SearchKey.Contains(param.SearchKey));

        //     if (false == String.IsNullOrEmpty(param.FirstName))
        //         Ret = Ret.Where(c => c.FirstName.Contains(param.FirstName));

        //     if (false == String.IsNullOrEmpty(param.LastName))
        //         Ret = Ret.Where(c => c.LastName.Contains(param.LastName));

        //     if (false == String.IsNullOrEmpty(param.FamilyName))
        //         Ret = Ret.Where(c => c.FamilyName.Contains(param.FamilyName));

        //     if (false == String.IsNullOrEmpty(param.MobileNumber))
        //         Ret = Ret.Where(c => c.MobileNumber.Contains(param.MobileNumber));

        //     if (false == String.IsNullOrEmpty(param.NationalID))
        //         Ret = Ret.Where(c => c.NationalID.Contains(param.NationalID));

        //     Ret = Ret.OrderByDescending(c => c.CREATE_DT);

        //     return Ret.Take(param.cRecords).ToArray();
        // }

    }
}
