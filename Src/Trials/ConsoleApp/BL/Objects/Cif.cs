using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL.Objects
{
    public partial class Cif
    {
        
        static public string Add_CIF (
            DateTime    dtEFFECTIVE_DT,
            short       nCompanyNo,
            byte        nCIF_TYPE,
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
            int newRecod;

            // check Company
            if(false == Company.ValidateExists(nCompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");
            
            // check DEF_CIF_CLASS
            if(false == CifClass.ValidateExists(nCIF_CLASS, nCompanyNo))
                throw new ArgumentOutOfRangeException("nCIF_CLASS", "Class Code doesn't Exists");

            //IF NOT EXISTS (select top 1 Code from LUT_CIF_TYPE where Code = @CIF_TYPE)
            if(false == CifTYPE.ValidateExists(nCIF_TYPE))
                throw new ArgumentOutOfRangeException("nCIF_TYPE", "Type doesn't Exists");

            // check if CIF not exists
            if( false == ValidateExists(sCIF_NO))
            {
                // check if CIF exists in this company or not
                if(CIFCompany.ValidateExists(nCompanyNo, sCIF_NO))
                    throw new ArgumentException("sCIF_NO", "Provided CIF_NO Already exists per Given Company");
                else
                {
                    newRecod = CIFCompany.AddCompany(nCompanyNo, sCIF_NO);
                    if(newRecod == 0)
                        throw new ArgumentException("nCompanyNo", "Failed to Add this Company Per CIF");
                    return sCIF_NO;
                }
                
            }

            sCIF_NO = GenerateNewCode(sCIF_NO);
            
	        if(sSearchKey.Length <= 0)
                sSearchKey = sCIF_NO;
            
            // check if Search is not exists
            if(false == ValidateSearchKeyExists(sSearchKey))
                throw new ArgumentOutOfRangeException("SearchKey", "Search Key Already Exists");

            db.Database.BeginTransaction();
            
            // Insert into DB
            DEF_CIF newCIF = new DEF_CIF();
            newCIF.FirstName = sFirstName;
            newCIF.LAST_SAVE_DT = dtEFFECTIVE_DT;
            newCIF.MiddleName = sMiddleName;
            newCIF.LastName = sLastName;
            newCIF.SearchKey = sSearchKey;
            newCIF.CIF_NO = sCIF_NO;
            newCIF.CREATE_DT = DateTime.Now;
            newCIF.CIF_TYPE = nCIF_TYPE;
            newCIF.CIF_CLASS = nCIF_CLASS;
            newCIF.NationalID = sNationalID;
            
            db.DEF_CIF.Add(newCIF);
            if (0 == db.SaveChanges())
            {
                db.Database.RollbackTransaction();
                return string.Empty;
            }

            newRecod = CIFCompany.AddCompany(nCompanyNo, sCIF_NO);
            if(newRecod == 0)
                throw new ArgumentException("nCompanyNo", "Failed to Add this Company Per CIF");
                
            db.Database.CommitTransaction();
            
            return sCIF_NO;
        }

        protected static bool ValidateExists(string sCIF_NO)
        {
            OpenCoreContext db = new OpenCoreContext();

            string sExists =    (from c in db.DEF_CIF
                                where c.CIF_NO == sCIF_NO
                                select c.CIF_NO).FirstOrDefault();

            if( false == string.IsNullOrEmpty(sExists))
                return false;
            return true;
        }
        

        protected static bool ValidateSearchKeyExists(string sSearchKey)
        {
            OpenCoreContext db = new OpenCoreContext();

            string sExists =    (from c in db.DEF_CIF
                                where c.SearchKey == sSearchKey
                                select c.SearchKey).FirstOrDefault();

            if(false == string.IsNullOrEmpty(sExists))
                return false;
            return true;
        }
            



        protected static string GenerateNewCode(string sCIF_NO)
        {
            OpenCoreContext db = new OpenCoreContext();
            object CIFLock = new object();

            // if @CIF_NO is provided
            if(!string.IsNullOrEmpty(sCIF_NO))
            {
                //fn_OPT_GetCIFFormatDigitsNum
                if(sCIF_NO.Length > Settings.fn_OPT_GetCIFFormatDigitsNum())
                {
                    throw new ArgumentOutOfRangeException("sCIF_NO", "Provided CIF_NO Length is greater than Digits Length");
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

            return sCIF_NO;

        }
           
    }
}
