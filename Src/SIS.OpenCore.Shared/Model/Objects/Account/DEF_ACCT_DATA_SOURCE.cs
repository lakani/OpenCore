﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;

#nullable disable

namespace SIS.OpenCore.Shared.Model.Objects.Account
{
    public partial class DEF_ACCT_DATA_SOURCE : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return ACCT_DATA_SOURCE_ID;
        }
        public short ACCT_DATA_SOURCE_ID { get; set; }
        public string Name { get; set; }
        public string REFERENCE { get; set; }
        public string CONNECTIONTYPE  { get; set; }
        public string DATABASE  { get; set; }
        public string USERNAME  { get; set; }
        public string PASSWORD  { get; set; }
    }
}