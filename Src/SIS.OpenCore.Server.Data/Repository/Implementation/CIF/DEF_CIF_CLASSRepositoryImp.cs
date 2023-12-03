using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System;

#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.CIF
{
    public class DEF_CIF_CLASSRepositoryImp : GenericRepository<DEF_CIF_CLASS>, IDEF_CIF_CLASSRepository<DEF_CIF_CLASS>
    {
        public DEF_CIF_CLASSRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_CIF_CLASS> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("DEF_CIF_CLASSRepositoryImp");
        }

        override public DEF_CIF_CLASS? GetById(int id)
        {
            DEF_CIF_CLASS? Ret = (from t in _dbContext.DEF_CIF_CLASS
                                where t.CIF_CLASS_ID == id
                                select t).FirstOrDefault();

            return Ret;
        }

        override public async Task<int> Create(DEF_CIF_CLASS entity)
        {
            try
            {
                await _dbContext.Set<DEF_CIF_CLASS>().AddAsync(entity);
                await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in DEF_CIF_CLASSRepositoryImp:Create");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                    _logger.LogError(ex.InnerException.ToString());
                throw new Exception(ex.Message);
            }
        }
    }
}
