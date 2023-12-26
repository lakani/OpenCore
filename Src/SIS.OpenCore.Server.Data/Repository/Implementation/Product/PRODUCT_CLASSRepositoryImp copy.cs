using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Product;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;

//PRODUCT_DESCRepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Product
{
    public class PRODUCT_DESCRepositoryImp : GenericRepository<PRODUCT_DESC>, IPRODUCT_DESCRepository<PRODUCT_DESC>
    {
        public PRODUCT_DESCRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<PRODUCT_DESC> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("PRODUCT_DESCRepositoryImp");
        }

        
		override public IQueryable<PRODUCT_DESC> GetAll()
		{
			return _dbContext.Set<PRODUCT_DESC>().AsNoTracking();
		}

		override public PRODUCT_DESC? GetById(int id)
		{
			PRODUCT_DESC? Ret = (from   t in _dbContext.PRODUCT_DESC
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}