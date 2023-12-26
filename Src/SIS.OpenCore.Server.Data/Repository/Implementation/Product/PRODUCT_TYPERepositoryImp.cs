using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Product;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//PRODUCT_TYPERepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Product
{
    public class PRODUCT_TYPERepositoryImp : GenericRepository<PRODUCT_TYPE>, IPRODUCT_TYPERepository<PRODUCT_TYPE>
    {
        public PRODUCT_TYPERepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<PRODUCT_TYPE> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("PRODUCT_TYPERepositoryImp");
        }

        
		override public IQueryable<PRODUCT_TYPE> GetAll()
		{
			return _dbContext.Set<PRODUCT_TYPE>().AsNoTracking();
		}

		override public PRODUCT_TYPE? GetById(int id)
		{
			PRODUCT_TYPE? Ret = (from   t in _dbContext.PRODUCT_TYPE
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}