using System.Linq;
using System;
using SIS.OpenCore.EL;

namespace SIS.OpenCore.BL.Objects
{
    public partial class LUTGLAccountCategory
    {
        static public bool ValidateExists(short GLCategory)
        {
            OpenCoreContext db = new OpenCoreContext();
            short Ret ;

            Ret =   (from r in db.LUT_GL_ACCT_CATEGORY
                    where r.ID == GLCategory
                    select r.ID).First();
            if(Ret == 0 )
                return false;

            return true;
        }
    }
}