using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//LUT_CIF_TYPERepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.CIF
{
    public class LUT_CIF_TYPERepositoryImp : GenericRepository<LUT_CIF_TYPE>, ILUTRepository<LUT_CIF_TYPE>
    {
        public LUT_CIF_TYPERepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<LUT_CIF_TYPE> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("LUT_CIF_TYPERepositoryImp");
        }

        
		override public IQueryable<LUT_CIF_TYPE> GetAll()
		{
			return _dbContext.Set<LUT_CIF_TYPE>().AsNoTracking();
		}

		override public LUT_CIF_TYPE? GetById(int id)
		{
			LUT_CIF_TYPE? Ret = (from   t in _dbContext.LUT_CIF_TYPE
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}