﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;

#nullable disable

namespace SIS.OpenCore.Shared.Model.Objects.Account
{
    public partial class CIF_ACCT_CLASS : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return ACCT_CLASS_ID;
        }
        public short ACCT_CLASS_ID { get; set; }
        public string Name { get; set; }
        public short ACCT_TYPE { get; set; }
        public string REFERENCE { get; set; }
        public bool ExternallyManged  { get; set; }
        public LUT_ACCT_TYPE lUT_ACCT_TYPE { get; set; }

        //public ICollection<CIF_CK_ACCT> CIF_CK_ACCT { get; } = new List<CIF_CK_ACCT>();
    }
}