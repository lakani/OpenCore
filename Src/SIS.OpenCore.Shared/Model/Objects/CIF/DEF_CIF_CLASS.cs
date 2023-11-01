using System;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Shared.Model.Objects.CIF
{
    public partial class DEF_CIF_CLASS : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return CIF_CLASS_ID;
        }
        public short CIF_CLASS_ID { get; set; }
		public string Name { get; set; }
        public short CIF_TYPE { get; set; }
        public string REFERENCE { get; set; }
        public LUT_CIF_TYPE lUT_CIF_TYPE { get; set; }
        public ICollection<DEF_CIF> DEF_CIF { get; } = new List<DEF_CIF>();
    }
}