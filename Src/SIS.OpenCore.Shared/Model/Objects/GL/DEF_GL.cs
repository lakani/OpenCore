﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;

#nullable enable

namespace SIS.OpenCore.Shared.Model.Objects.GL
{
    public partial class DEF_GL : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return GL_DEFID;
        }
        public int GL_DEFID { get; set; }
        public short CompanyNo { get; set; }
        public short? Zone { get; set; }
        public short? BranchNo { get; set; }
        public short? SectorNo { get; set; }
        public short? DepNo { get; set; }
        public short? UnitNO { get; set; }
        public short? ProductNo { get; set; }
        public short Nature { get; set; }
        public int LedgerNO { get; set; }
        public string? GL { get; set; }
        //public string CURR { get; set; } // its not on the parent level
        public string? COMMENTS { get; set; }
        public DateTime EFFECTIVE_DT { get; set; }
        public short STATUS { get; set; }
        public string? REFERENCE { get; set; }
    }
}