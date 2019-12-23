using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using ConsoleApp.EF;


namespace ConsoleApp.EF
{
    public partial class DefCif
    {
        
        static public string Add_CIF (
            DateTime    dtEFFECTIVE_DT,
            short       nCompanyNo,
            short       nCIF_TYPE,
            string      nCIF_CLASS,
            string      sNationalID ,
            string      sFirstName,
            string      sMiddleName = "",
            string      sLastName = "",
            string      sSearchKey = "",
            string      sCIF_NO = ""
        )
        {
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.DefCompany
                        where c.Id == nCompanyNo
                        select c.Name).First();
            if(Ret.Length <= 0)
                return "";  

            // check DEF_CIF_CLASS
            Ret =   (from c in db.DefCifClass
                    where c.Code == nCIF_CLASS
                    select c.Name).First();
            if(Ret.Length <= 0)
                return "";  

            //IF NOT EXISTS (select top 1 Code from LUT_CIF_TYPE where Code = @CIF_TYPE)
            Ret =   (from c in db.LutCifType
                    where c.Code == nCIF_TYPE
                    select c.Name).First();
            if(Ret.Length <= 0)
                return "";  

            


            return "CIF00001";


        }
    }
}
