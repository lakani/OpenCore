using System;
using System.Collections.Generic;

//SIS.OpenCore.Shared\Model\Objects\Common\DEF_EMP.cs
// DEF_EMP
namespace SIS.OpenCore.Shared.Model.Objects.Common
{
    public partial class EMP
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
        public short? STATUS_ID { get; set; }
    }
}
