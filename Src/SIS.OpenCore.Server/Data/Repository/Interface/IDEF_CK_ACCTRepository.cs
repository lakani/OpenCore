﻿using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;


namespace SIS.OpenCore.Server.Data.Repository.Interface
{
    public interface IDEF_CK_ACCTRepository<TEntity> :   IGenericRepository<TEntity> where TEntity : class, BaseEntity
    {
        
    }
}