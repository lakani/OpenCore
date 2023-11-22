using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface IACCT_DATA_SOURCERepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
    }
}