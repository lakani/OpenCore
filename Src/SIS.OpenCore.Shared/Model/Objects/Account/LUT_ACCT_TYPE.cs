using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Shared.Model.Objects.Account
{
    public partial class LUT_ACCT_TYPE : BaseLUTEntity
    {
        //public ICollection<DEF_CIF_CLASS> DEF_CIF_CLASS { get; } = new List<DEF_CIF_CLASS>();
        public ICollection<DEF_ACCT_CLASS> DEF_ACCT_CLASS { get; } = new List<DEF_ACCT_CLASS>();

    }
}


