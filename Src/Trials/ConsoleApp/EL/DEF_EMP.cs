using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class DEF_EMP
    {
        public short EMP_ID { get; set; }
        public string CIF_NO { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string FamilyName { get; set; }
        public DateTime? CREATE_DT { get; set; }
        public DateTime? LAST_SAVE_DT { get; set; }
        public string MobileNumber { get; set; }
        public string HomeNumber { get; set; }
        public string WorkNumber { get; set; }
        public byte? STATUS_ID { get; set; }
    }
}
