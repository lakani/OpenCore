using System.Linq;
using System;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;



namespace SIS.OpenCore.BL.Objects
{
    public partial class Sector
    {
        public static bool ValidateExists(byte nSector)
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Sector
            var Ret =   (from c in db.DEF_Sector
                        where c.ID == nSector
                        select c.Name).FirstOrDefault();
            if(String.IsNullOrEmpty (Ret))
                return false;  
            
            return true;
        }
    }
}