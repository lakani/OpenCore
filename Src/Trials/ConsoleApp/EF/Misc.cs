
using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using ConsoleApp.EF;


namespace ConsoleApp.EF
{
    public partial class Misc
    {
        
        static public int fn_OPT_GetCIFFormatDigitsNum()
        {
            //-- Add the SELECT statement with parameter references here
	        //    return (	SELECT top 1	LEN(rtrim(Options.CIFFormatDigits))
			//	from			OpenCore.dbo.Settings Options 
			//	order by Options.VerID desc
            return fn_OPT_GetCIFFormatDigits().Length;
        }

        static public String fn_OPT_GetCIFFormatDigits()
        {
            OpenCoreContext db = new OpenCoreContext();

            String CIFFormatDigits =    ((from s in db.Settings
                                        orderby s.VerId descending
                                        select s.CifformatDigits).First()).Trim();
            
            return CIFFormatDigits;
        }
        
    }
}

