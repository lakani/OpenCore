using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Account;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System;

#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Account
{
    public class CIF_ACCT_CLASSRepositoryImp : GenericRepository<CIF_ACCT_CLASS>, ICIF_ACCT_CLASSRepository<CIF_ACCT_CLASS>
    {
        public CIF_ACCT_CLASSRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<CIF_ACCT_CLASS> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("CIF_ACCT_CLASSRepositoryImp");
        }

        override public CIF_ACCT_CLASS? GetById(int id)
        {
            CIF_ACCT_CLASS? Ret = (from t in _dbContext.CIF_ACCT_CLASS
                                where t.ACCT_CLASS_ID == id
                                select t).FirstOrDefault();

            return Ret;
        }

        override public async Task<int> Create(CIF_ACCT_CLASS entity)
        {
            try
            {
                await _dbContext.Set<CIF_ACCT_CLASS>().AddAsync(entity);
                await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in CIF_ACCT_CLASSRepositoryImp:Create");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                    _logger.LogError(ex.InnerException.ToString());
                throw new Exception(ex.Message);
            }
        }
    }
}
