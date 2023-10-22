using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

namespace SIS.OpenCore.Server.Data.Repository.Implementation.UserData
{
    public class BranchRepositoryImp : GenericRepository<DEF_Branch>, IUserDataRepository<DEF_Branch>
    {
        public BranchRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_Branch> logger)
        : base(dbContext, configuration, logger)
        {
			logger.LogInformation("BranchRepositoryImp");
        }

        public override async Task Create(DEF_Branch entity)
        {
            try
            {
				_dbContext.DEF_Branch.Add(entity);
				await _dbContext.SaveChangesAsync();
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

        override public DEF_Branch GetById(int id)
        {
            var Ret =   (from c in _dbContext.DEF_Branch
                        where c.ID == id
                        select c).FirstOrDefault();
            return  Ret;
        }

        override public IQueryable<DEF_Branch> Search(BaseRequesModel requesModel)
        {
            throw new NotImplementedException();
        }
    }
}
