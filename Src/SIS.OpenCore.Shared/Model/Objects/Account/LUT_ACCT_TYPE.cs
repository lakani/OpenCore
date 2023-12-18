using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Shared.Model.Objects.Account
{
    public partial class LUT_ACCT_TYPE : BaseLUTEntity
    {
        public ICollection<CIF_ACCT_CLASS> CIF_ACCT_CLASS { get; } = new List<CIF_ACCT_CLASS>();

    }
}


