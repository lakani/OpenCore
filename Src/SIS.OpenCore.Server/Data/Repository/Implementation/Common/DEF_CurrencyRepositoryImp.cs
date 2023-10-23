using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.GL;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Server.Data.Repository.Implementation
{
    public partial  class DEF_CurrencyRepositoryImp : GenericRepository<DEF_Currency>, IDEF_CurrencyRepository<DEF_Currency>
    {
        public DEF_CurrencyRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_Currency> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("DEF_CurrencyRepositoryImp");
        }

        override public DEF_Currency GetByCode(string code)
		{
			var Ret =   (from c in _dbContext.DEF_Currency
                        where c.ISOCode == code
                        select c).FirstOrDefault();
            return Ret;
		}


        // public static bool ValidateExists(string stISO)
        // {
        //     OpenCoreContext db = new OpenCoreContext();

        //     // select ISOCode from DEF_Currency where ISOCode = 'EGP'
        //     var Ret =   (from c in db.DEF_Currency
        //                 where c.ISOCode == stISO
        //                 select c.ISOCode).FirstOrDefault();
        //     if(true == String.IsNullOrEmpty (Ret))
        //         return false;  
            
        //     return true;
        // }
    }
}