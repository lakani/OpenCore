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
    public class CIF_CLASSRepositoryImp : GenericRepository<CIF_CLASS>, ICIF_CLASSRepository<CIF_CLASS>
    {
        public CIF_CLASSRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<CIF_CLASS> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("CIF_CLASSRepositoryImp");
        }

        override public CIF_CLASS? GetById(int id)
        {
            CIF_CLASS? Ret = (from t in _dbContext.CIF_CLASS
                                where t.CIF_CLASS_ID == id
                                select t).FirstOrDefault();

            return Ret;
        }

        override public async Task<int> Create(CIF_CLASS entity)
        {
            try
            {
                await _dbContext.Set<CIF_CLASS>().AddAsync(entity);
                await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in CIF_CLASSRepositoryImp:Create");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                    _logger.LogError(ex.InnerException.ToString());
                throw new Exception(ex.Message);
            }
        }
    }
}
