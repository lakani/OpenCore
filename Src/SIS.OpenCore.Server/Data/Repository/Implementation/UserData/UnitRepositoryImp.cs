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
    public class UnitRepositoryImp : GenericRepository<DEF_Unit>, IUserDataRepository<DEF_Unit>
    {
        public UnitRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_Unit> Logger)
        : base(dbContext, configuration, Logger)
        {
			_logger.LogInformation("UnitRepositoryImp");
        }

        public override async Task<int> Create(DEF_Unit entity)
        {
            try
            {
				_dbContext.DEF_Unit.Add(entity);
				await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
			}
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                if(ex.InnerException != null)
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

        override public DEF_Unit GetById(int id)
        {
            throw new NotImplementedException();
        }

        override public IQueryable<DEF_Unit> Search(BaseRequesModel requesModel)
        {
            throw new NotImplementedException();
        }
    }
}
