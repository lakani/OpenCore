using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EF
{
    public partial class DefEmp
    {
        public short EmpId { get; set; }
        public string CifNo { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string FamilyName { get; set; }
        public DateTime? CreateDt { get; set; }
        public DateTime? LastSaveDt { get; set; }
        public string MobileNumber { get; set; }
        public string HomeNumber { get; set; }
        public string WorkNumber { get; set; }
        public byte? StatusId { get; set; }
    }
}
