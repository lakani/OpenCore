
using System.Linq;
using System;
using SIS.OpenCore.EF;


namespace SIS.OpenCore.BL
{
    public partial class Settings
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

        static public String fn_OPT_GetBaseCurrency()
        {
            OpenCoreContext db = new OpenCoreContext();

            String sBaseCurrency =      ((from s in db.Settings
                                        orderby s.VerId descending
                                        select s.BaseCurrency).First()).Trim();
            
            return sBaseCurrency;
        }
        
        
    }
}

