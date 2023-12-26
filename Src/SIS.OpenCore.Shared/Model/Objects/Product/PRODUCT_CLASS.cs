using SIS.OpenCore.Shared.Model.Common;
#nullable disable

namespace SIS.OpenCore.Shared.Model.Objects.Product
{
    public partial class PRODUCT_CLASS : BaseEntity
    {
        //PRODUCT_CLASS (ID, NAME, PRODUCT_TYPE, CURRENCY, PRODUCT_FAMILY, PRODUCT_SUB_TYPE, PRODUCT_CHANNEL , DESCRIPTION )
        public int GetPrimaryKey()
        {
            return ID;
        }
        public short    ID                  { get; set; }
		public string   Name                { get; set; }
        public short    PRODUCT_TYPE        { get; set; }
        public string   CURRENCY            { get; set; }
        public short    PRODUCT_FAMILY      { get; set; }
        public short    PRODUCT_SUB_TYPE    { get; set; }
        public short    PRODUCT_CHANNEL     { get; set; }
        public string   DESCRIPTION         { get; set; }
    }
}