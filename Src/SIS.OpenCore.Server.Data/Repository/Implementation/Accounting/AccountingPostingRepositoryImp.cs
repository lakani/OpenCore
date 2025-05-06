using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.GL;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Transactions.Posting;
using Microsoft.AspNetCore.Http.HttpResults;

namespace SIS.OpenCore.Server.Data.Repository.Implementation
{
    public partial  class AccountingPostingRepositoryImp : GenericRepository<AccountingPosting>, IAccountingPostingRepository<AccountingPosting>
    {
        public AccountingPostingRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<AccountingPosting> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("AccountingPostingRepositoryImp");
        }


        //Task<int> Create(TEntity entity);
        //override public IQueryable<CIF_DESC> Search(BaseRequesModel requesModel)
        override public async Task<int> Create(AccountingPosting entity)
		{
			try
			{
				await _dbContext.AccountingPosting.AddAsync(entity);
				await _dbContext.SaveChangesAsync();
				return entity.GetPrimaryKey();
			}
			catch (Exception ex)
			{
				_logger.LogError(ex.Message);
				if (ex.InnerException != null)
				{
					_logger.LogError("AccountingPostingRepositoryImp -> Create");
					_logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
				}
				throw new Exception(ex.Message);
			}
		}

    }
}