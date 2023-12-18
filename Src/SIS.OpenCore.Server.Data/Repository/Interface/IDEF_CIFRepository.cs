using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface ICIF_DESCRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
    }
}