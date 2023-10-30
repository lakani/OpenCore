using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Shared.Model.Objects.Account;

//LUT_ACCT_TYPERepositoryImp
#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Account
{
    public class LUT_ACCT_TYPERepositoryImp : GenericRepository<LUT_ACCT_TYPE>, ILUTRepository<LUT_ACCT_TYPE>
    {
        public LUT_ACCT_TYPERepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<LUT_ACCT_TYPE> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("LUT_ACCT_TYPERepositoryImp");
        }

        
		override public IQueryable<LUT_ACCT_TYPE> GetAll()
		{
			return _dbContext.Set<LUT_ACCT_TYPE>().AsNoTracking();
		}

		override public LUT_ACCT_TYPE? GetById(int id)
		{
			LUT_ACCT_TYPE? Ret = (from   t in _dbContext.LUT_ACCT_TYPE
                                where   t.ID == id
                                select  t).FirstOrDefault();

            return Ret;
		}

        //virtual public TEntity? GetByCode(string code)
        override public LUT_ACCT_TYPE? GetByCode(string code)
		{
			LUT_ACCT_TYPE? Ret = (from   t in _dbContext.LUT_ACCT_TYPE
                                where   t.Name == code
                                select  t).FirstOrDefault();

            return Ret;
		}
    }
}