using SIS.OpenCore.Shared.Model;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface ISettingsRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
        
    }
}


