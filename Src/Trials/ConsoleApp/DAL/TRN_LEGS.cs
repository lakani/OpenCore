﻿using System;
using System.Collections.Generic;

namespace SIS.OpenCore.DAL.TODO // Check the correct table attributes
{
    public partial class TRN_LEGS
    {
        public int TRN_LEGS_ID { get; set; }
        public Guid? Ref { get; set; }
        public short? Sequence { get; set; }
        public string Acct_CR_DR { get; set; }
        public string Acct_No { get; set; }
        public bool? GL { get; set; }
        public decimal? Balance_Before { get; set; }
        public decimal? Trn_Amt { get; set; }
        public decimal? Balance_After { get; set; }
        public string Acct_Curr { get; set; }
        public DateTime? EffDt { get; set; }
        public DateTime? CREATE_DT { get; set; }
        public short? EMP_ID { get; set; }
        public byte? STATUS_ID { get; set; }
        public short? CHANNEL_ID { get; set; }
        public short? Category { get; set; }
        public string Acct_Description { get; set; }
        public Guid? Related_Ref { get; set; }
    }
}
