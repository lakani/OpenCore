using System.Linq;
using System.Threading.Tasks;
using SIS.OpenCore.Shared;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;

#nullable enable

namespace SIS.OpenCore.Server.Data.Repository.Interface
{
	public interface IGenericRepository<TEntity> where TEntity : class, BaseEntity
	{
		IQueryable<TEntity> GetAll();

		TEntity? GetById(int id);

		TEntity? GetByCode(string code);

		Task Create(TEntity entity);

		IQueryable<TEntity> Search(BaseRequesModel requesModel);

		Task Update(int id, TEntity entity);

		Task Delete(int id);
	}
}
