using SIS.OpenCore.Shared.Model;

namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface ILUTRepository <TEntity> : IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {

    }
}


