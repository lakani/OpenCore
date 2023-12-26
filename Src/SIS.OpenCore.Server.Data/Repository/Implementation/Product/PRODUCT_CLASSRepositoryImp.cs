using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Product;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//PRODUCT_CLASSRepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Product
{
    public class PRODUCT_CLASSRepositoryImp : GenericRepository<PRODUCT_CLASS>, IPRODUCT_CLASSRepository<PRODUCT_CLASS>
    {
        public PRODUCT_CLASSRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<PRODUCT_CLASS> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("PRODUCT_CLASSRepositoryImp");
        }

        
		override public IQueryable<PRODUCT_CLASS> GetAll()
		{
			return _dbContext.Set<PRODUCT_CLASS>().AsNoTracking();
		}

		override public PRODUCT_CLASS? GetById(int id)
		{
			PRODUCT_CLASS? Ret = (from   t in _dbContext.PRODUCT_CLASS
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}