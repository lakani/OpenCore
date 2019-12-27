using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using ConsoleApp.EF;
using ConsoleApp.BL;


namespace ConsoleApp.BL
{
    public partial class Cif
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
            object CIFLock = new object();
            OpenCoreContext db = new OpenCoreContext();

            // check Company
            var Ret =   (from c in db.DefCompany
                        where c.Id == nCompanyNo
                        select c.Name).FirstOrDefault();
            if(Ret.Length<= 0)
                return "";  

            // check DEF_CIF_CLASS
            Ret =   (from c in db.DefCifClass
                    where c.Code == nCIF_CLASS
                    select c.Name).FirstOrDefault();
            if(string.IsNullOrEmpty(Ret))
                return "";  

            //IF NOT EXISTS (select top 1 Code from LUT_CIF_TYPE where Code = @CIF_TYPE)
            Ret =   (from c in db.LutCifType
                    where c.Code == nCIF_TYPE
                    select c.Name).FirstOrDefault();
            if(string.IsNullOrEmpty(Ret))
                return "";  


            // if @CIF_NO is provided
            if(!string.IsNullOrEmpty(sCIF_NO))
            {
                //fn_OPT_GetCIFFormatDigitsNum
                if(sCIF_NO.Length > Misc.fn_OPT_GetCIFFormatDigitsNum())
                {
                    return "";
                }
            }
            else // its not provided
            {
                // 000000000
                lock(CIFLock)
                {
                    // Get Max CIF Number
                    string sMax =   (from r in db.DefCif
                                    select r.CifNo).Max();
                    
                    if (string.IsNullOrEmpty(sMax))
                        sMax = 0.ToString();
                    
                    int nMax = int.Parse(sMax);
                    nMax = nMax + 1;
                    sMax = Misc.fn_OPT_GetCIFFormatDigits() + nMax.ToString();
                    int cToRemove = sMax.Length - Misc.fn_OPT_GetCIFFormatDigitsNum();
                    sCIF_NO = sMax.Remove(0, cToRemove);
                }
            }

            // check if CIF not exists
            string sExists =    (from c in db.DefCif
                                where c.CifNo == sCIF_NO
                                select c.CifNo).FirstOrDefault();
            if( !string.IsNullOrEmpty(sExists))
                return "";
            
	        
            if(sSearchKey.Length <= 0)
                sSearchKey = sCIF_NO;
            
            // check if Search is not exists
             sExists =  (from c in db.DefCif
                        where c.SearchKey == sSearchKey
                        select c.SearchKey).FirstOrDefault();
            if(! string.IsNullOrEmpty(sExists))
                return "";

            
            // Insert into DB
            DefCif newCIF = new DefCif();
            newCIF.FirstName = sFirstName;
            newCIF.LastSaveDt = dtEFFECTIVE_DT;
            newCIF.MiddleName = sMiddleName;
            newCIF.LastName = sLastName;
            newCIF.SearchKey = sSearchKey;
            newCIF.CifNo = sCIF_NO;
            
            
            db.DefCif.Add(newCIF);
            if (0 == db.SaveChanges())
                return "";
            
            return sCIF_NO;
        }
    }
}
