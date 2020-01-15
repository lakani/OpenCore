using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL.Objects
{
    public partial class CifClass
    {
        
        static public string Add_CIF_CLASS (
            DateTime    dtEFFECTIVE_DT,
            short       nCompanyNo,
            byte        nCIF_TYPE,
            string      sCIFClassName,
            string      sCIFClassCode = "",
            string      sReference = ""
        )
        {
            object CIFLock = new object();
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            if(!Company.ValidateExists(nCompanyNo))
                return "";  

            if(!CIFTYPE.ValidateExists(nCIF_TYPE))
                return "";
            
            if(string.IsNullOrEmpty(sCIFClassCode))
                sCIFClassCode = "01";
            
            return sCIFClassCode;
        }
    }
}
