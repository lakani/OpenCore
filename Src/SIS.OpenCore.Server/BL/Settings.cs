using System.Linq;
using System;
using SIS.OpenCore.DAL;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;


namespace SIS.OpenCore.Server.BL
{
    public partial class Settings
    {
        private static  ISettingsRepository<SettingsModel> _SettingsRep;
        private static  IConfiguration _configuration;
        private static  ILogger _logger;
        private static  SettingsModel _lastVersionSettings = null;

        public static void InitServices(ILogger logger,IConfiguration configuration, ISettingsRepository<SettingsModel> SettingsRep)
        {
            _logger = logger;
            _configuration = configuration;
            _SettingsRep = SettingsRep;
            if(_lastVersionSettings == null)
                _lastVersionSettings = SettingsRep.Search(new BaseRequesModel()).First();
        }

        // static public int fn_OPT_GetCIFFormatDigitsNum()
        // {
        //     //-- Add the SELECT statement with parameter references here
	    //     //    return (	SELECT top 1	LEN(rtrim(Options.CIFFormatDigits))
		// 	//	from			OpenCore.dbo.Settings Options 
		// 	//	order by Options.VerID desc
        //     return fn_OPT_GetCIFFormatDigits().Length;
        // }

        

        public static SettingsModel GetLastVersion()
        {
			OpenCoreContext db = new OpenCoreContext();

			SettingsModel LastVersion = (from s in db.Settings
                                    orderby s.VerID descending
									select s ).First();

			return LastVersion;
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
            if(_lastVersionSettings == null)
                _lastVersionSettings = _SettingsRep.Search(new BaseRequesModel()).First();
                            
            String sGlformat = _lastVersionSettings.GLFormat.Trim();
            return sGlformat;
        }

        static public short fn_OPT_GetGLFormatDigitsNum()
        {
            //string r = fn_OPT_GetGLFormatDigits();
            string r = "######";

            if (String.IsNullOrEmpty(r)) 
                return 0;
            return (short)r.Length;
        }

        static public short fn_OPT_GetGLMAXLength()
        {
            return 35;
        }
       
    }
}

