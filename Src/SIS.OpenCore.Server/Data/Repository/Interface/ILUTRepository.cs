using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface ILUTRepository <TEntity> : IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {

    }
}


