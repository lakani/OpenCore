using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface  IDEF_CurrencyRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {

    }
}