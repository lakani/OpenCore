using System.Linq;
using System;
using SIS.OpenCore.DAL;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.DAL.Context;

namespace SIS.OpenCore.Server.BL.Transactions
{
    public partial class TRAN_POST_AE_CATEGORY
    {
        static public bool ValidateExists(short nCATEGORY)
        {
            //LUT_AE_CATEGORY
            OpenCoreContext db = new OpenCoreContext();
            short nID = (from r in db.LUT_AE_CATEGORY
                        where r.ID == nCATEGORY
                        select r.ID).FirstOrDefault();
            if(nID == 0)
                return false;
            return true;
        }
    }
}