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
    public class ACCTDataSourceRepositoryImp : GenericRepository<ACCTDataSource>, IACCTDataSourceRepository<ACCTDataSource>
    {
        public ACCTDataSourceRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<ACCTDataSource> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("ACCTDataSourceRepositoryImp");
        }

        override public ACCTDataSource? GetById(int id)
        {
            ACCTDataSource? Ret = (from t in _dbContext.ACCTDataSource
                                where t.ACCTDataSource_ID == id
                                select t).FirstOrDefault();

            return Ret;
        }

        override public async Task<int> Create(ACCTDataSource entity)
        {
            try
            {
                await _dbContext.Set<ACCTDataSource>().AddAsync(entity);
                await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in ACCTDataSourceRepositoryImp:Create");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                    _logger.LogError(ex.InnerException.ToString());
                throw new Exception(ex.Message);
            }
        }
    }
}
