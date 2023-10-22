using SIS.OpenCore.Shared.Model;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface IDEF_CIF_CLASSRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
    }
}