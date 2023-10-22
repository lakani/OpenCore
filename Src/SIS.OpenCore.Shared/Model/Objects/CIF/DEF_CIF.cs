﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;
#nullable disable

namespace SIS.OpenCore.Shared.Model.Objects.CIF
{
    public partial class DEF_CIF : BaseEntity
    {
        public int CIF_ID { get; set; }
        public string CIF_NO { get; set; }
        public string SearchKey { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string FamilyName { get; set; }
        public DateTime CREATE_DT { get; set; }
        public short CLASS_ID { get; set; }
        public string RSM { get; set; }
        public string REFERENCE { get; set; }
        public DateTime LAST_SAVE_DT { get; set; }
        public DEF_CIF_PERSONAL? PERSONAL { get; set; }
        public DEF_CIF_CLASS DEF_CIF_CLASS { get; set; }
    }
}