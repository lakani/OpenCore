﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace SIS.OpenCore.Shared.Model.Common
{
    //ExchangeRatesConfig
    //IExchangeRatesRepositoryImp
    public partial class ExchangeRates : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return ExchangeRateID;
        }
        public int ExchangeRateID  { get; set; }
        public string FromCurrency { get; set; }
        public string ToCurrency { get; set; }
        public decimal Rate { get; set; }
        public DateTime EffectiveDate { get; set; }
    }
}