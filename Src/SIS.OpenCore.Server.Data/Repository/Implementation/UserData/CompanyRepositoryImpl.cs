using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.UserData
{
	public class CompanyRepositoryImpl : GenericRepository<Company >, IUserDataRepository<Company >
	{
		public CompanyRepositoryImpl(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<Company > logger)
		: base(dbContext, configuration, logger)
		{
			logger.LogInformation("CompanyRepositoryImpl"); 
		}

		public override async Task<int> Create(Company  entity)
		{
			try
			{
				_dbContext.Company .Add(entity);
				await _dbContext.SaveChangesAsync();
				return entity.GetPrimaryKey();
			}
			catch (Exception ex)
			{
				_logger.LogError(ex.Message);
				if (ex.InnerException != null)
					_logger.LogError(ex.InnerException.ToString());
				throw new Exception(ex.Message);
			}
		}

		public override Company ? GetById(int id)
		{
			// check Company
            var Ret =   (from c in _dbContext.Company 
                        where c.ID == id
                        select c ).FirstOrDefault();
            return Ret;
		}
	}
}
