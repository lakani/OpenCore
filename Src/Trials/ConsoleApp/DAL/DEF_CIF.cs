using System;
using System.Collections.Generic;

namespace SIS.OpenCore.DAL.TODO // Check the correct table attributes
{
    public partial class DEF_CIF
    {
        public int Id { get; set; }
        public string CIF_NO { get; set; }
        public string SearchKey { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string FamilyName { get; set; }
        public DateTime? CREATE_DT { get; set; }
        public short? CIF_TYPE { get; set; }
        public string CIF_CLASS { get; set; }
        public string RSM { get; set; }
        public string Gender { get; set; }
        public int? Country { get; set; }
        public int? COUNTRY_OF_BIRTH { get; set; }
        public int? GOVERNORATE { get; set; }
        public int? City { get; set; }
        public int? Area { get; set; }
        public string Address { get; set; }
        public int? Nationality { get; set; }
        public DateTime? BIRTH_DT { get; set; }
        public DateTime? LAST_SAVE_DT { get; set; }
        public string MobileNumber { get; set; }
        public string HomeNumber { get; set; }
        public string WorkNumber { get; set; }
        public string NationalID { get; set; }
    }
}
