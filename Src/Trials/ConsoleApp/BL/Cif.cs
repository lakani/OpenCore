using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL
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
            if(!Company.ValidateExists(nCompanyNo))
                return "";  
            
            // check DEF_CIF_CLASS
            var Ret =   (from c in db.DEF_CIF_CLASS
                        where c.Code == nCIF_CLASS
                        select c.Name).FirstOrDefault();
            if(string.IsNullOrEmpty(Ret))
                return "";  

            //IF NOT EXISTS (select top 1 Code from LUT_CIF_TYPE where Code = @CIF_TYPE)
            Ret =   (from c in db.LUT_CIF_TYPE
                    where c.Code == nCIF_TYPE
                    select c.Name).FirstOrDefault();
            if(string.IsNullOrEmpty(Ret))
                return "";  


            // if @CIF_NO is provided
            if(!string.IsNullOrEmpty(sCIF_NO))
            {
                //fn_OPT_GetCIFFormatDigitsNum
                if(sCIF_NO.Length > Settings.fn_OPT_GetCIFFormatDigitsNum())
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
                    string sMax =   (from r in db.DEF_CIF
                                    select r.CIF_NO).Max();
                    
                    if (string.IsNullOrEmpty(sMax))
                        sMax = 0.ToString();
                    
                    int nMax = int.Parse(sMax);
                    nMax = nMax + 1;
                    sMax = Settings.fn_OPT_GetCIFFormatDigits() + nMax.ToString();
                    int cToRemove = sMax.Length - Settings.fn_OPT_GetCIFFormatDigitsNum();
                    sCIF_NO = sMax.Remove(0, cToRemove);
                }
            }

            // check if CIF not exists
            string sExists =    (from c in db.DEF_CIF
                                where c.CIF_NO == sCIF_NO
                                select c.CIF_NO).FirstOrDefault();
            if( !string.IsNullOrEmpty(sExists))
                return "";
            
	        
            if(sSearchKey.Length <= 0)
                sSearchKey = sCIF_NO;
            
            // check if Search is not exists
             sExists =  (from c in db.DEF_CIF
                        where c.SearchKey == sSearchKey
                        select c.SearchKey).FirstOrDefault();
            if(! string.IsNullOrEmpty(sExists))
                return "";

            db.Database.BeginTransaction();
            
            // Insert into DB
            DEF_CIF newCIF = new DEF_CIF();
            newCIF.FirstName = sFirstName;
            newCIF.LAST_SAVE_DT = dtEFFECTIVE_DT;
            newCIF.MiddleName = sMiddleName;
            newCIF.LastName = sLastName;
            newCIF.SearchKey = sSearchKey;
            newCIF.CIF_NO = sCIF_NO;
            
            
            db.DEF_CIF.Add(newCIF);
            if (0 == db.SaveChanges())
            {
                db.Database.RollbackTransaction();
                return "";
            }
                
            
            db.Database.CommitTransaction();
            return sCIF_NO;
        }
    }
}
