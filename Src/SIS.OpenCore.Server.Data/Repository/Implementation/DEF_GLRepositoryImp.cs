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

namespace SIS.OpenCore.Server.Data.Repository.Implementation
{
    public class DEF_GLRepositoryImp : GenericRepository<DEF_GL>, IDEF_GLRepository<DEF_GL>
    {
        public DEF_GLRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_GL> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("DEF_GLRepositoryImp");
        }

        override public DEF_GL GetByCode(string code)
		{
			var Ret =   (from c in _dbContext.DEF_GL
                        where c.GL == code
                        select c).FirstOrDefault();
            return Ret;
		}

		public int GetMaxLedger(short nCompany, short nNature, short? nZone, short? nBranch, short? nSector,
                                          short? nDep, short? nUNITNO, short? nProduct)
        {
            //GL.CompanyNo = @CompanyNo AND GL.Zone = @Zone AND Gl.BranchNo = @BranchNo AND Gl.SectorNo = @SectorNo)
            int ?nMaxLedger = (from g in _dbContext.DEF_GL
                              where g.CompanyNo == nCompany &&
                                    g.Nature == nNature &&
                                    g.BranchNo == nBranch &&
                                    g.SectorNo == nSector &&
                                    g.DepNo == nDep &&
                                    g.UnitNO == nUNITNO && 
                                    g.ProductNo == nProduct 
                              select (int?)g.LedgerNO).Max();
            if(nMaxLedger.HasValue)
                return nMaxLedger.Value;
            else
                return 0;
        }

        override public async Task<int> Create(DEF_GL entity)
		{
			try
			{
				var AddRet = await _dbContext.Set<DEF_GL>().AddAsync(entity);
				var SaveRet = await _dbContext.SaveChangesAsync();

                return entity.GetPrimaryKey();
			}
			catch (Exception ex)
			{
                _logger.LogError("Error in DEF_GLRepositoryImp:Create");
				_logger.LogError(ex.Message);
				if (ex.InnerException != null)
					_logger.LogError(ex.InnerException.ToString());
				throw new Exception(ex.Message);
			}
		}
    }
}


