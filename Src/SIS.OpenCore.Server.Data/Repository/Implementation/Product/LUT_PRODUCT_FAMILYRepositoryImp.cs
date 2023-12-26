using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Product;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//LUT_PRODUCT_FAMILYRepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Product
{
    public class LUT_PRODUCT_FAMILYRepositoryImp : GenericRepository<LUT_PRODUCT_FAMILY>, ILUTRepository<LUT_PRODUCT_FAMILY>
    {
        public LUT_PRODUCT_FAMILYRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<LUT_PRODUCT_FAMILY> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("LUT_PRODUCT_FAMILYRepositoryImp");
        }

        
		override public IQueryable<LUT_PRODUCT_FAMILY> GetAll()
		{
			return _dbContext.Set<LUT_PRODUCT_FAMILY>().AsNoTracking();
		}

		override public LUT_PRODUCT_FAMILY? GetById(int id)
		{
			LUT_PRODUCT_FAMILY? Ret = (from   t in _dbContext.LUT_PRODUCT_FAMILY
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}