using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Account;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System;

#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Account
{
    public class ACCT_DATA_SOURCERepositoryImp : GenericRepository<ACCT_DATA_SOURCE>, IACCT_DATA_SOURCERepository<ACCT_DATA_SOURCE>
    {
        public ACCT_DATA_SOURCERepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<ACCT_DATA_SOURCE> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("ACCT_DATA_SOURCERepositoryImp");
        }

        override public ACCT_DATA_SOURCE? GetById(int id)
        {
            ACCT_DATA_SOURCE? Ret = (from t in _dbContext.ACCT_DATA_SOURCE
                                where t.ACCT_DATA_SOURCE_ID == id
                                select t).FirstOrDefault();

            return Ret;
        }

        override public async Task<int> Create(ACCT_DATA_SOURCE entity)
        {
            try
            {
                await _dbContext.Set<ACCT_DATA_SOURCE>().AddAsync(entity);
                await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ACCT_DATA_SOURCERepositoryImp:Create");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                    _logger.LogError(ex.InnerException.ToString());
                throw new Exception(ex.Message);
            }
        }
    }
}
