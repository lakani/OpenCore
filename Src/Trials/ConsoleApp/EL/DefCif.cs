using System;
using System.Collections.Generic;

namespace ConsoleApp.EF
{
    public partial class DefCif
    {
        public int Id { get; set; }
        public string CifNo { get; set; }
        public string SearchKey { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string FamilyName { get; set; }
        public DateTime? CreateDt { get; set; }
        public short? CifType { get; set; }
        public string CifClass { get; set; }
        public string Gender { get; set; }
        public int? Country { get; set; }
        public int? CountryOfBirth { get; set; }
        public int? Governorate { get; set; }
        public int? City { get; set; }
        public int? Area { get; set; }
        public string Address { get; set; }
        public int? Nationality { get; set; }
        public DateTime? BirthDt { get; set; }
        public DateTime? LastSaveDt { get; set; }
        public string MobileNumber { get; set; }
        public string HomeNumber { get; set; }
        public string WorkNumber { get; set; }
        public string NationalId { get; set; }
    }
}
