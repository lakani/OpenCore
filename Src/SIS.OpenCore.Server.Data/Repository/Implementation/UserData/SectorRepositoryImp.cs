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
    public class SectorRepositoryImp : GenericRepository<Sector>, IUserDataRepository<Sector>
    {
        public SectorRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<Sector> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("SectorRepositoryImp");
        }

        public override async Task<int> Create(Sector entity)
        {
			try
            {
				_dbContext.Sector.Add(entity);
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

        override public Sector GetById(int id)
        {
            // check Sector
            var Ret =   (from c in _dbContext.Sector
                        where c.ID == id
                        select c ).FirstOrDefault();
            return Ret;
        }

        override public IQueryable<Sector> Search(BaseRequesModel requesModel)
        {
            throw new NotImplementedException();
        }
    }
}
