using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.EF;
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
                int         Zone = 0,
                int         BranchNo = 0,
                int         SectorNo = 0,
                int         DepNo = 0,
                int         UNITNO = 0,
                string      CURR = "" ,
                int         POSTINGLEVEL = 1,
                String      LEDGERNO = "",
                string      TotallingGL = "",
                string      COMMENTS = "",
                string      REFERENCE	=""
         )      
         {
             //-- if not supplied , assume its the base currency
             //-- if not supplied , assume its current bussiness date
             //-- check paramters
                //PRINT 'Checking DEF_Currency Table'
                //PRINT 'Checking Company in DEF_Company Table'
                //PRINT 'Checking DEF_Zone Table'
                //PRINT 'Checking DEF_Branch Table'
                //PRINT 'Checking DEF_Sector Table'
                //PRINT 'Checking DEF_Dep Table'
                //PRINT 'Checking DEF_Unit Table'
             return "GL";
         }    
    }
}