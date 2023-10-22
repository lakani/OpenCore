using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface ISettingsRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
        public int GetCIFFormatDigitsNum();
        public string GetCIFFormatDigits();
    }
}


