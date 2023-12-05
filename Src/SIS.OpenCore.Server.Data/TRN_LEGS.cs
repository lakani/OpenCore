using System;
using System.Collections.Generic;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Shared.Model;
using System.Linq;


namespace SIS.OpenCore.Server.Data.TODO // Check the correct table attributes
{
    public partial class TRN_LEGS_DAL
    {
        // static public bool ValidRef(Guid Ref)
        // {
        //     OpenCoreContext db = new OpenCoreContext();
        //     short ?LegsStatus =  (from l in db.TRN_LEGS
        //                         where l.Ref == Ref 
        //                         select l.STATUS_ID).FirstOrDefault() ;
            
        //     if (LegsStatus.HasValue==true)
        //         if(LegsStatus == 1)
        //             return true;
        //     return false;
        // }
        
    }
}
