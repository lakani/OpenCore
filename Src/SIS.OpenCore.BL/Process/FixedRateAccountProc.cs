﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;

namespace SIS.OpenCore.BL.Process
{
    public partial class FixedRateAccountProc
    {
        /// <summary>
        /// Interest Calculation Process for All Accounts
        /// </summary>
        static public void InterestCalculationProcess(DateTime RunDate)
        {
            // Get All Fixed Rate Active Accounts
            DEF_FIXRATE_ACCT[] ActiveAccTs = FixedRateAccount_DAL.List(0);
            foreach (DEF_FIXRATE_ACCT FixedAcct in ActiveAccTs)
            {
                InterestCalculationProcess(FixedAcct, RunDate);
            }
        }


        /// <summary>
        /// Interest Calculation Process for sepcific Account
        /// </summary>
        static public void InterestCalculationProcess(DEF_FIXRATE_ACCT Acct, DateTime RunDate)
        {
            PROC_FIXRATE_INTEREST LastAccrual = PROC_FIXRATE_INTEREST_DAL.GetLastActiveInterestProcess(Acct);

            // if already executed for the Given Date
            if (LastAccrual.TO_DATE >= RunDate)
                return;
            else
            {
                PROC_FIXRATE_INTEREST NewInterestRecord = new PROC_FIXRATE_INTEREST();

                NewInterestRecord.FROM_DATE = LastAccrual.TO_DATE;
                NewInterestRecord.TO_DATE = RunDate;
                NewInterestRecord.PRINCIPLE_AMT = Acct.Principle;
                NewInterestRecord.STATUS_ID = 1;
                NewInterestRecord.ACCT_NO = Acct.ACCT_NO;
                NewInterestRecord.CIF_NO = Acct.CIF_NO;
                NewInterestRecord.CALC_INTEREST_AMT = CalcDayInterest(Acct, LastAccrual.TO_DATE, RunDate);

                PROC_FIXRATE_INTEREST_DAL.Create(NewInterestRecord);
            }
        }

        /// <summary>
        /// Calc Interest for the given (From date, To Date) and Fiven account
        /// </summary>
        static public decimal CalcDayInterest(DEF_FIXRATE_ACCT Acct, DateTime FromDate, DateTime ToDate)
        {
            decimal CalcInterest = 0;
            for (DateTime x = FromDate; x <= ToDate; x = x.AddDays(1))
            {
                CalcInterest += CalcDayInterest(Acct, x);
            }
            return CalcInterest;
        }

        /// <summary>
        /// Calc Interest for the given date and Fiven account
        /// </summary>
        static public decimal CalcDayInterest(DEF_FIXRATE_ACCT Acct, DateTime RunDate)
        {
            // TODO, currently only the 30/360 is supported, TODO support other accrual basis 
            decimal Daily = 0, Ret = 0;

            if (Acct.Rate.HasValue)
            {
                Daily = Acct.Principle / 360;
                Ret = Daily * Acct.Rate.Value;
            }
            return Ret;
        }
    }
}