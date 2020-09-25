using System;
using System.Collections.Generic;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.Model;
using System.Linq;


namespace SIS.OpenCore.DAL // Check the correct table attributes
{
    public partial class TRN_LEGS_DAL
    {
        static public bool ValidRef(Guid Ref)
        {
            OpenCoreContext db = new OpenCoreContext();
            byte ?LegsStatus =  (from l in db.TRN_LEGS
                                where l.Ref == Ref 
                                select l.STATUS_ID).FirstOrDefault() ;
            
            if (LegsStatus.HasValue==true)
                if(LegsStatus == 1)
                    return true;
            return false;
        }
        
    }
}
