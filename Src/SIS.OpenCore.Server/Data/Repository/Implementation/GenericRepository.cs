using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using System.Linq;
using System.Threading.Tasks;
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

#nullable enable

namespace SIS.OpenCore.Server.Data.Repository.Implementation
{
	public class GenericRepository<TEntity> : IGenericRepository<TEntity> where TEntity : class, BaseEntity
	{
		protected readonly ApplicationDbContext _dbContext;
		protected readonly IConfiguration _configuration;
		protected readonly ILogger<TEntity> _logger;

		public GenericRepository(ApplicationDbContext dbContext, IConfiguration Configuration, ILogger<TEntity> logger)
		{
			_configuration = Configuration;
			_dbContext = dbContext;
			_logger = logger;
		}

		virtual public async Task Create(TEntity entity)
		{
			try
			{
				await _dbContext.Set<TEntity>().AddAsync(entity);
				await _dbContext.SaveChangesAsync();
			}
			catch (Exception ex)
			{
				_logger.LogError(ex.Message);
				if (ex.InnerException != null)
				{
					_logger.LogError("Inner Exception");
					_logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
				}
				throw new Exception(ex.Message);
			}
		}

		virtual public async Task Delete(int id)
		{
			var entity = GetById(id);
			if (entity != null)
			{
				_dbContext.Set<TEntity>().Remove(entity);
				await _dbContext.SaveChangesAsync();
			}

		}

		virtual public IQueryable<TEntity> GetAll()
		{
			return _dbContext.Set<TEntity>().AsNoTracking();
		}

		virtual public TEntity? GetByCode(string code)
		{
			throw new NotImplementedException();
		}

		virtual public TEntity? GetById(int id)
		{
			//         //return _dbContext.Set<TEntity>().fi

			//         var record = (from p in _dbContext.Set<TEntity>
			//			  where p.PatientID == id
			//			  select p).First();
			//if (record != null)
			//{
			//	return record;
			//}
			//return null;

			throw new NotImplementedException();
		}

		virtual public IQueryable<TEntity> Search(BaseRequesModel requesModel)
		{
			throw new NotImplementedException();
		}

		virtual public async Task Update(int id, TEntity entity)
		{
			_dbContext.Set<TEntity>().Update(entity);
			await _dbContext.SaveChangesAsync();
		}
	}
}
