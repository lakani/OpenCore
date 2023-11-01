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
    public class DEF_ACCT_CLASSRepositoryImp : GenericRepository<DEF_ACCT_CLASS>, IDEF_ACCT_CLASSRepository<DEF_ACCT_CLASS>
    {
        public DEF_ACCT_CLASSRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_ACCT_CLASS> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("DEF_ACCT_CLASSRepositoryImp");
        }

        override public DEF_ACCT_CLASS? GetById(int id)
        {
            DEF_ACCT_CLASS? Ret = (from t in _dbContext.DEF_ACCT_CLASS
                                where t.ACCT_CLASS_ID == id
                                select t).FirstOrDefault();

            return Ret;
        }

        override public async Task<int> Create(DEF_ACCT_CLASS entity)
        {
            try
            {
                await _dbContext.Set<DEF_ACCT_CLASS>().AddAsync(entity);
                await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in DEF_ACCT_CLASSRepositoryImp:Create");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                    _logger.LogError(ex.InnerException.ToString());
                throw new Exception(ex.Message);
            }
        }
    }
}
