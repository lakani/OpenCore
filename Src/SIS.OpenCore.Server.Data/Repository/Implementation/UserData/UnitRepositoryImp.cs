using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
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
    public class UnitRepositoryImp : GenericRepository<Unit>, IUserDataRepository<Unit>
    {
        public UnitRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<Unit> Logger)
        : base(dbContext, configuration, Logger)
        {
			_logger.LogInformation("UnitRepositoryImp");
        }

        public override async Task<int> Create(Unit entity)
        {
            try
            {
				_dbContext.Unit.Add(entity);
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

        override public Unit GetById(int id)
        {
            throw new NotImplementedException();
        }

        override public IQueryable<Unit> Search(BaseRequesModel requesModel)
        {
            throw new NotImplementedException();
        }
    }
}
