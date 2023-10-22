﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace SIS.OpenCore.Shared.Model.Objects.CIF
{
    // Contact Info 
    // Applicable only for Personal
    // DEF_CIF_PERSONAL
    public partial class DEF_CIF_PERSONAL  : BaseEntity
    {
        public int DEF_CIF_PERSONALID { get; set; }
        public short? Country { get; set; }
        public short? GOVERNORATE { get; set; }
        public short? City { get; set; }
        public int? Area { get; set; }
        public string Address { get; set; }
        public bool Gender { get; set; }
        public short? COUNTRY_OF_BIRTH { get; set; }
        public short? Nationality { get; set; }
        public DateTime? BIRTH_DT { get; set; }
        public string MobileNumber { get; set; }
        public string HomeNumber { get; set; }
        public string WorkNumber { get; set; }
        public string NationalID { get; set; }
        public int CIF_ID { get; set; }
        public DEF_CIF DEF_CIF{ get; set; } = null!;
    }
}
