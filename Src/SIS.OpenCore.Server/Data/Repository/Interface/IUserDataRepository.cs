using SIS.OpenCore.Shared.Model;

namespace SIS.OpenCore.Server.Data.Repository.Interface
{
	public interface IUserDataRepository<TEntity> : IGenericRepository<TEntity> where TEntity : class, BaseEntity
	{
	}
}
