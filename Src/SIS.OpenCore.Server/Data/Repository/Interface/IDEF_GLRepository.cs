using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface IDEF_GLRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
        public int GetMaxLedger(short nCompany, short nNature, short? nZone, short? nBranch, short? nSector,
                                          short? nDep, short? nUNITNO, short? nProduct);
        

    }
}




