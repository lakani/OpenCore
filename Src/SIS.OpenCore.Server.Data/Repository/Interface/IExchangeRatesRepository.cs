using Microsoft.VisualBasic;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface  IExchangeRatesRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
        public string Convert(string FromCurrency, string ToCurrency, DateAndTime date);
    }
}


