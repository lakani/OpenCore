using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
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
    public partial  class CurrencyRepositoryImp : GenericRepository<Currency>, ICurrencyRepository<Currency>
    {
        public CurrencyRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<Currency> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("CurrencyRepositoryImp");
        }

        override public Currency GetByCode(string code)
		{
			var Ret =   (from c in _dbContext.Currency
                        where c.ISOCode == code
                        select c).FirstOrDefault();
            return Ret;
		}


        // public static bool ValidateExists(string stISO)
        // {
        //     OpenCoreContext db = new OpenCoreContext();

        //     // select ISOCode from Currency where ISOCode = 'EGP'
        //     var Ret =   (from c in db.Currency
        //                 where c.ISOCode == stISO
        //                 select c.ISOCode).FirstOrDefault();
        //     if(true == String.IsNullOrEmpty (Ret))
        //         return false;  
            
        //     return true;
        // }
    }
}