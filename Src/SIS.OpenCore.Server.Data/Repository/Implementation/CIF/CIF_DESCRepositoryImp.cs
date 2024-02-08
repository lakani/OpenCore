using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Shared.Model.Common;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Shared.Model.GetRequest;




namespace SIS.OpenCore.Server.Data.Repository.Implementation.CIF
{
    public class CIF_DESCRepositoryImp : GenericRepository<CIF_DESC>, ICIF_DESCRepository<CIF_DESC>
    {
        public CIF_DESCRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<CIF_DESC> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("CIF_DESCRepositoryImp");
        }

        override public CIF_DESC GetByCode(string code)
		{
			var Ret =   (from c in _dbContext.CIF_DESC
                        where c.SearchKey == code || c.CIF_NO == code
                        select c)
                        .Include(a => a.CIF_CLASS)
                        .Include(a => a.CIF_CLASS.lUT_CIF_TYPE)
                        .FirstOrDefault();

            return Ret;
		}


        override public IQueryable<CIF_DESC> Search(BaseRequesModel requesModel)
		{
            GetCIFRequestModel cifRequestModel = (GetCIFRequestModel)requesModel;
            var CIFs =      from C in _dbContext.CIF_DESC
                            select C ;
            
            CIFs = CIFs.Include(a => a.CIF_CLASS);
            CIFs = CIFs.Include(a => a.CIF_CLASS.lUT_CIF_TYPE);
            
            if(cifRequestModel.CIF_ID.HasValue && cifRequestModel.CIF_ID != 0)   {
                CIFs = CIFs.Where(c => c.CIF_ID == cifRequestModel.CIF_ID);
            }
            if(string.IsNullOrEmpty(cifRequestModel.CIF_NO) == false)   {
                CIFs = CIFs.Where(c => c.CIF_NO.Contains(cifRequestModel.CIF_NO));
            }
            if(string.IsNullOrEmpty(cifRequestModel.SearchKey) == false)   {
                CIFs = CIFs.Where(c => c.SearchKey.Contains(cifRequestModel.SearchKey));
            }
            if(string.IsNullOrEmpty(cifRequestModel.FirstName) == false)   {
                CIFs = CIFs.Where(c => c.FirstName.Contains(cifRequestModel.FirstName));
            }
            if(string.IsNullOrEmpty(cifRequestModel.MiddleName) == false)   {
                CIFs = CIFs.Where(c => c.MiddleName.Contains(cifRequestModel.MiddleName));
            }
            if(string.IsNullOrEmpty(cifRequestModel.LastName) == false)   {
                CIFs = CIFs.Where(c => c.LastName.Contains(cifRequestModel.LastName));
            }
            if(string.IsNullOrEmpty(cifRequestModel.FamilyName) == false)   {
                CIFs = CIFs.Where(c => c.FamilyName.Contains(cifRequestModel.FamilyName));
            }
                        
            return CIFs.AsQueryable().Take(requesModel.ResponseMaxRecords>0?requesModel.ResponseMaxRecords:10);
		}

        override public CIF_DESC GetById(int id)
		{
			if(id == -1)
            {
                string sMax =   (from r in _dbContext.CIF_DESC
                                select r.CIF_NO).Max();

                if (string.IsNullOrEmpty(sMax))
                    sMax = 0.ToString();
                return new CIF_DESC{ CIF_NO = sMax};
            }
            else
            {
                var Ret =   (from c in _dbContext.CIF_DESC
                            where c.CIF_ID == id
                            select c)
                            .Include(a => a.CIF_CLASS)
                            .Include(a => a.CIF_CLASS.lUT_CIF_TYPE)
                            .FirstOrDefault();

                return Ret;
            }
		}
    }
}


