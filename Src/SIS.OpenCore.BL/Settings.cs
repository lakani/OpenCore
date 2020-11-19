using System.Linq;
using System;
using SIS.OpenCore.DAL;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL.Context;


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
                                        orderby s.VerID descending
                                        select s.CIFFormatDigits).FirstOrDefault()).Trim();
            
            return CIFFormatDigits;
        }

        static public String fn_OPT_GetBaseCurrency()
        {
            OpenCoreContext db = new OpenCoreContext();

            String sBaseCurrency =      ((from s in db.Settings
                                        orderby s.VerID descending
                                        select s.BaseCurrency).FirstOrDefault()).Trim();
            
            return sBaseCurrency;
        }

        /// <summary>
        /// Return the Current Business Date
        /// </summary>
        static public DateTime GetCurrentBusinessDate()
        {
            // TODO , should return the last executed Business Date as per the End of date EOD Process 
            return DateTime.Today;
        }

        static public string fn_OPT_GetGLFormatDigits()
        {
            /*
            OpenCoreContext db = new OpenCoreContext();

            String sGlformatDigits =    ((from s in db.Settings
                                        orderby s.VerID descending
                                        select s.GLFormatDigits).FirstOrDefault()).Trim();
            */

            String sGlformatDigits = "######";

            return sGlformatDigits;
        }

        static public string GetSystemSegments()
        {
            OpenCoreContext db = new OpenCoreContext();

            String sGlformat =  ((from s in db.Settings
                                orderby s.VerID descending
                                select s.GLFormat).FirstOrDefault()).Trim();

            return sGlformat;
        }

        static public byte fn_OPT_GetGLFormatDigitsNum()
        {
            //string r = fn_OPT_GetGLFormatDigits();
            string r = "######";

            if (String.IsNullOrEmpty(r)) 
                return 0;
            return (byte)r.Length;
        }

        static public byte fn_OPT_GetGLMAXLength()
        {
            return 35;
        }
       
    }
}

