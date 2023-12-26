using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Product;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//LUT_PRODUCT_CHANNELRepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Product
{
    public class LUT_PRODUCT_CHANNELRepositoryImp : GenericRepository<LUT_PRODUCT_CHANNEL>, ILUTRepository<LUT_PRODUCT_CHANNEL>
    {
        public LUT_PRODUCT_CHANNELRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<LUT_PRODUCT_CHANNEL> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("LUT_PRODUCT_CHANNELRepositoryImp");
        }

        
		override public IQueryable<LUT_PRODUCT_CHANNEL> GetAll()
		{
			return _dbContext.Set<LUT_PRODUCT_CHANNEL>().AsNoTracking();
		}

		override public LUT_PRODUCT_CHANNEL? GetById(int id)
		{
			LUT_PRODUCT_CHANNEL? Ret = (from   t in _dbContext.LUT_PRODUCT_CHANNEL
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}