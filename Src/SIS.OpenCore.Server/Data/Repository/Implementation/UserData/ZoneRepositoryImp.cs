using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace SIS.OpenCore.Server.Data.Repository.Implementation.UserData
{
    public class ZoneRepositoryImp : GenericRepository<DEF_Zone>, IUserDataRepository<DEF_Zone>
    {
        public ZoneRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_Zone> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("ZoneRepositoryImp");
        }

        public override async Task<int> Create(DEF_Zone entity)
        {
            try
            {
				await _dbContext.DEF_Zone.AddAsync(entity);
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

        override public DEF_Zone GetById(int id)
        {
            // check Company
            var Ret =   (from c in _dbContext.DEF_Zone
                        where c.ID == id
                        select c).FirstOrDefault();
            return Ret;
        }

        

        override public IQueryable<DEF_Zone> Search(BaseRequesModel requesModel)
        {
            throw new NotImplementedException();
        }
    }
}
