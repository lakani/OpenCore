using SIS.OpenCore.Shared.Model;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    //DEF_GLRepositoryImp
    public interface IDEF_GLRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
        public int GetMaxLedger(short nCompany, short nNature, short? nZone, short? nBranch, short? nSector,
                                          short? nDep, short? nUNITNO, short? nProduct);
        

    }
}




