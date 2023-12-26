﻿using SIS.OpenCore.Shared.Model.Common;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface IPRODUCT_CLASSRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
    }
}