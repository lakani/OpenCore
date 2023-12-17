using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

namespace SIS.OpenCore.Server.Data.Repository.Implementation.UserData
{
    public class DepRepositoryImp : GenericRepository<Dep>, IUserDataRepository<Dep>
    {
        public DepRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<Dep> logger)
        : base(dbContext, configuration, logger)
        {
			logger.LogInformation("DepRepositoryImp");
        }

        public override async Task<int> Create(Dep entity)
        {
            try
            {
				_dbContext.Dep.Add(entity);
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

        //public Task Create(BaseLut entity)
        //{
        //	throw new NotImplementedException();
        //}

        public Task Update(int id, BaseUserData entity)
        {
            throw new NotImplementedException();
        }

        override public Dep GetById(int id)
        {
            throw new NotImplementedException();
        }

        override public IQueryable<Dep> Search(BaseRequesModel requesModel)
        {
            throw new NotImplementedException();
        }
    }
}
