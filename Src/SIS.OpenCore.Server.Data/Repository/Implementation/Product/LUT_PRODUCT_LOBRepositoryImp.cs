using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Product;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//LUT_PRODUCT_LOBRepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Product
{
    public class LUT_PRODUCT_LOBRepositoryImp : GenericRepository<LUT_PRODUCT_LOB>, ILUTRepository<LUT_PRODUCT_LOB>
    {
        public LUT_PRODUCT_LOBRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<LUT_PRODUCT_LOB> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("LUT_PRODUCT_LOBRepositoryImp");
        }

        
		override public IQueryable<LUT_PRODUCT_LOB> GetAll()
		{
			return _dbContext.Set<LUT_PRODUCT_LOB>().AsNoTracking();
		}

		override public LUT_PRODUCT_LOB? GetById(int id)
		{
			LUT_PRODUCT_LOB? Ret = (from   t in _dbContext.LUT_PRODUCT_LOB
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}