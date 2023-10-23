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
using Microsoft.VisualBasic;

namespace SIS.OpenCore.Server.Data.Repository.Implementation
{
    public partial  class ExchangeRatesRepositoryImp : GenericRepository<ExchangeRates>, IExchangeRatesRepository<ExchangeRates>
    {
        public ExchangeRatesRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<ExchangeRates> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("ExchangeRatesRepositoryImp");
        }

        public string Convert(string FromCurrency, string ToCurrency, DateAndTime date)
        {
            throw new NotImplementedException();
        }
    }
}