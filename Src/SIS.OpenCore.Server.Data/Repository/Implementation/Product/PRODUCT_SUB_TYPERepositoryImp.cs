using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Product;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//PRODUCT_SUB_TYPERepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Product
{
    public class PRODUCT_SUB_TYPERepositoryImp : GenericRepository<PRODUCT_SUB_TYPE>, IPRODUCT_SUB_TYPERepository<PRODUCT_SUB_TYPE>
    {
        public PRODUCT_SUB_TYPERepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<PRODUCT_SUB_TYPE> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("PRODUCT_SUB_TYPERepositoryImp");
        }

        
		override public IQueryable<PRODUCT_SUB_TYPE> GetAll()
		{
			return _dbContext.Set<PRODUCT_SUB_TYPE>().AsNoTracking();
		}

		override public PRODUCT_SUB_TYPE? GetById(int id)
		{
			PRODUCT_SUB_TYPE? Ret = (from   t in _dbContext.PRODUCT_SUB_TYPE
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}