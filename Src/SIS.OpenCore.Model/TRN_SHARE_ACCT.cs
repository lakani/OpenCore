﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace SIS.OpenCore.Model
{
    public partial class TRN_SHARE_ACCT
    {
        public int TRN_SHARE_ACCT_ID { get; set; }
        public Guid? Ref { get; set; }
        public string ACCT_NO { get; set; }
        public DateTime TRAN_DT { get; set; }
        public DateTime SETTLMENT_DT { get; set; }
        public byte TRAN_TYPE_ID { get; set; }
        public decimal TRAN_QTY { get; set; }
        public decimal UNIT_PRICE { get; set; }
        public decimal TRAN_AMT { get; set; }
        public decimal TRAN_P_L { get; set; }
    }
}