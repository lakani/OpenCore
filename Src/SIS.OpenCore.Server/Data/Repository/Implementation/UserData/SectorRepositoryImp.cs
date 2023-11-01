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
    public class SectorRepositoryImp : GenericRepository<DEF_Sector>, IUserDataRepository<DEF_Sector>
    {
        public SectorRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_Sector> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("SectorRepositoryImp");
        }

        public override async Task<int> Create(DEF_Sector entity)
        {
			try
            {
				_dbContext.DEF_Sector.Add(entity);
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

        override public DEF_Sector GetById(int id)
        {
            // check Sector
            var Ret =   (from c in _dbContext.DEF_Sector
                        where c.ID == id
                        select c ).FirstOrDefault();
            return Ret;
        }

        override public IQueryable<DEF_Sector> Search(BaseRequesModel requesModel)
        {
            throw new NotImplementedException();
        }
    }
}
