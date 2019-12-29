using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
//using SIS.OpenCore.EL;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL
{
    public partial class GL
    {
            //@LEDGERNO_OUT	nvarchar(15)	OUTPUT,
            // @CompanyNo		int,
            // @Zone			int,
            // @BranchNo		int,
            // @SectorNo		int,
            // @DepNo			int,
            // @UNITNO			int,
            // @NATURE			int,
            // @LEDGERNO		nvarchar(MAX) = null,
            // @TotallingGL	nvarchar(100) = null,
            // @POSTINGLEVEL	int = null,
            // @CURR			nvarchar(4) = null, 
            // @COMMENTS		nvarchar(200) = null,
            // @EFFECTIVE_DT	datetime = null,
            // @REFERENCE		nvarchar(MAX) = null
         static public string Add_GL (
                DateTime    EFFECTIVE_DT ,
                int         CompanyNo,
                int         NATURE,
                int         nZone = 0,
                int         BranchNo = 0,
                int         SectorNo = 0,
                int         DepNo = 0,
                int         UNITNO = 0,
                string      CURR = "" ,
                int         POSTINGLEVEL = 1,
                string      LEDGERNO = "",
                string      TotallingGL = "",
                string      COMMENTS = "",
                string      REFERENCE	=""
         )      
         {
            //-- if not supplied , assume its the base currency
            if (String.IsNullOrEmpty(CURR))
                CURR = Settings.fn_OPT_GetBaseCurrency();
            
            //-- if not supplied , assume its current bussiness date
            if(EFFECTIVE_DT <= DateTime.MinValue || EFFECTIVE_DT >= DateTime.MaxValue )
                EFFECTIVE_DT = Settings.fn_OPT_GetCurrentBDate();

            //-- check paramters
                //PRINT 'Checking DEF_Currency Table'
                if(!Currency.ValidateExists(CURR))
                    return "";
                //PRINT 'Checking Company in DEF_Company Table'
                if(!Company.ValidateExists(CompanyNo))
                    return "";
                //PRINT 'Checking DEF_Zone Table'
                if(nZone != 0)
                    if(!Zone.ValidateExists((byte)nZone))
                        return "";
                //PRINT 'Checking DEF_Branch Table'
                if(BranchNo != 0)
                    if(!Branch.ValidateExists((short)BranchNo))
                        return "";
                //PRINT 'Checking DEF_Sector Table'
                //PRINT 'Checking DEF_Dep Table'
                //PRINT 'Checking DEF_Unit Table'

            
            
            return "GL";
         }    
    }
}