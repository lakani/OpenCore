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
    public class GL_ACCTRepositoryImp : GenericRepository<GL_ACCT>, IGL_ACCTRepository<GL_ACCT>
    {
        public GL_ACCTRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<GL_ACCT> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("GL_ACCTRepositoryImp");
        }

        override public GL_ACCT GetByCode(string code)
		{
			var Ret =   (from c in _dbContext.GL_ACCT
                        where c.GL == code
                        select c).FirstOrDefault();
            return Ret;
		}

		public int GetMaxLedger(short nCompany, short nNature, short? nZone, short? nBranch, short? nSector,
                                          short? nDep, short? nUNITNO, short? nProduct)
        {
            //GL.CompanyNo = @CompanyNo AND GL.Zone = @Zone AND Gl.BranchNo = @BranchNo AND Gl.SectorNo = @SectorNo)
            int ?nMaxLedger = (from g in _dbContext.GL_ACCT
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

        override public async Task<int> Create(GL_ACCT entity)
		{
			try
			{
				var AddRet = await _dbContext.Set<GL_ACCT>().AddAsync(entity);
				var SaveRet = await _dbContext.SaveChangesAsync();

                return entity.GetPrimaryKey();
			}
			catch (Exception ex)
			{
                _logger.LogError("Error in GL_ACCTRepositoryImp:Create");
				_logger.LogError(ex.Message);
				if (ex.InnerException != null)
					_logger.LogError(ex.InnerException.ToString());
				throw new Exception(ex.Message);
			}
		}
    }
}


