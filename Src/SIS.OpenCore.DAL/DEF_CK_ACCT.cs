using System;
using System.Collections.Generic;

namespace SIS.OpenCore.DAL.TODO // Check the correct table attributes
{
    public partial class DEF_CK_ACCT
    {
        public int DEF_ACCT_ID { get; set; }
        public string CIF_NO { get; set; }
        public string ACCT_NO { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string ReferenceACCT { get; set; }
        public string ReferenceOrg { get; set; }
        public string IBAN { get; set; }
        public string ACCT_TYPE { get; set; }
        public string ACCT_CLASS { get; set; }
        public string Currency { get; set; }
        public DateTime? OpenDate { get; set; }
        public string CSP_Code { get; set; }
        public short CompanyNo { get; set; }
        public byte? STATUS { get; set; }
    }
}
