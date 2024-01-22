using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.GL;
using SIS.OpenCore.Shared.Model.GetRequest;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.Shared.Model.Common;

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
                        select c)
                        .Include( a => a.CompanyObj)
                        .Include( a => a.ZoneObj)
                        .Include( a => a.BranchObj)
                        .Include( a => a.UnitObj)
                        .Include( a => a.SectorObj)
                        .Include( a => a.NatureObj)
                        .FirstOrDefault();
            return Ret;
		}
          
        override public GL_ACCT? GetById(int id)
        {
            var Ret =   (from c in _dbContext.GL_ACCT
                        where c.GL_DEFID == id
                        select c)
                        .Include( a => a.CompanyObj)
                        .Include( a => a.ZoneObj)
                        .Include( a => a.BranchObj)
                        .Include( a => a.UnitObj)
                        .Include( a => a.SectorObj)
                        .Include( a => a.NatureObj)
                        .FirstOrDefault();
            return Ret;
        }

        override public IQueryable<GL_ACCT> Search(BaseRequesModel requesModel)
		{
            GetGLLedgerRequestModel ledgerRequestModel = (GetGLLedgerRequestModel)requesModel;
            var GLS =       from G in _dbContext.GL_ACCT 
                            select G ;
            
            GLS = GLS.Include( a => a.CompanyObj);
            GLS = GLS.Include( a => a.ZoneObj);
            GLS = GLS.Include( a => a.BranchObj);
            GLS = GLS.Include( a => a.UnitObj);
            GLS = GLS.Include( a => a.SectorObj);
            GLS = GLS.Include( a => a.NatureObj);


            if(ledgerRequestModel.CompanyNo != 0)   {
                GLS = GLS.Where(g => g.CompanyNo == ledgerRequestModel.CompanyNo);
            }
            if(ledgerRequestModel.Zone.HasValue && ledgerRequestModel.Zone != 0)   {
                GLS = GLS.Where(g => g.Zone == ledgerRequestModel.Zone);
            }
            if(ledgerRequestModel.BranchNo.HasValue && ledgerRequestModel.BranchNo != 0)   {
                GLS = GLS.Where(g => g.BranchNo == ledgerRequestModel.BranchNo);
            }
            if(ledgerRequestModel.SectorNo.HasValue && ledgerRequestModel.SectorNo != 0)   {
                GLS = GLS.Where(g => g.SectorNo == ledgerRequestModel.SectorNo);
            }
            if(ledgerRequestModel.DepNo.HasValue && ledgerRequestModel.DepNo != 0)   {
                GLS = GLS.Where(g => g.DepNo == ledgerRequestModel.DepNo);
            }
            if(ledgerRequestModel.UnitNO.HasValue && ledgerRequestModel.UnitNO != 0)   {
                GLS = GLS.Where(g => g.UnitNO == ledgerRequestModel.UnitNO);
            }
            if(ledgerRequestModel.ProductNo.HasValue && ledgerRequestModel.ProductNo != 0)   {
                GLS = GLS.Where(g => g.ProductNo == ledgerRequestModel.ProductNo);
            }
            if(ledgerRequestModel.Nature.HasValue && ledgerRequestModel.Nature != 0)   {
                GLS = GLS.Where(g => g.Nature == ledgerRequestModel.Nature);
            }
            if(ledgerRequestModel.LedgerNO.HasValue && ledgerRequestModel.LedgerNO != 0)   {
                GLS = GLS.Where(g => g.LedgerNO == ledgerRequestModel.LedgerNO);
            }
            if(string.IsNullOrEmpty(ledgerRequestModel.GL)== false)   {
                GLS = GLS.Where(g => g.GL.Contains(ledgerRequestModel.GL));
            }
            
            return GLS.AsQueryable();
		}

		public int GetMaxLedger(short nCompany, short nNature, short? nZone, short? nBranch, short? nSector,
                                          short? nDep, short? nUNITNO, short? nProduct)
        {
            // fix for #106
            //GL.CompanyNo = @CompanyNo AND GL.Zone = @Zone AND Gl.BranchNo = @BranchNo AND Gl.SectorNo = @SectorNo)
            int ?nMaxLedger = (from g in _dbContext.GL_ACCT
                              where g.CompanyNo == nCompany &&
                                    g.Nature == nNature &&
                                    (!nBranch.HasValue || g.BranchNo == nBranch) &&
                                    (!nSector.HasValue || g.SectorNo == nSector) &&
                                    (!nDep.HasValue || g.DepNo == nDep) &&
                                    (!nUNITNO.HasValue || g.UnitNO == nUNITNO) && 
                                    (!nProduct.HasValue || g.ProductNo == nProduct) 
                              select (int?)g.LedgerNO).Max();
            if(nMaxLedger.HasValue)
                return nMaxLedger.Value;
            else
                return 0;
        }

        override public IQueryable<GL_ACCT> GetAll()
        {
            var ret =   (from g in _dbContext.GL_ACCT
                        select g)
                        .Include( a => a.CompanyObj)
                        .Include( a => a.ZoneObj)
                        .Include( a => a.BranchObj)
                        .Include( a => a.UnitObj)
                        .Include( a => a.SectorObj)
                        .Include( a => a.NatureObj)
                        .AsQueryable();
            
            return ret;
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


