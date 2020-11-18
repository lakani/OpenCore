using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;

namespace SIS.OpenCore.BL.Objects
{
    public partial class FixedRateAccount
    {

        static protected byte _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH = 15;
        static protected string _CURRENT_ACCOUNT_NUM_FORMAT = "000000000000000";

        /// <summary>
        /// create new Fixed Rate account for the given CIF
        /// </summary>
        public static string Create(DEF_FIXRATE_ACCT NewAcct, DEF_FIXRATE_ACCT_DATES[] SettlmentDates)
        {
            if (false == Company.ValidateExists(NewAcct.CompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");

            if (false == Currency.ValidateExists(NewAcct.Currency))
                throw new ArgumentOutOfRangeException("Currency", "Currency doesn't Exists");

            if (false == Cif.ValidateExists(NewAcct.CIF_NO))
                throw new ArgumentOutOfRangeException("CIF_NO", "CIF_NO doesn't Exists");

            //check dates
            if(NewAcct.CloseDate < Settings.GetCurrentBusinessDate())
                throw new ArgumentOutOfRangeException("CloseDate", "Close Date should be bigger than current date");

            if(NewAcct.CreateDate > NewAcct.OpenDate)
                throw new ArgumentOutOfRangeException("OpenDate", "Open Date should be bigger than Create date");

            if (false == Currency.ValidateExists(NewAcct.Currency))
                throw new ArgumentOutOfRangeException("Currency", "Currency doesn't Exists");

            if (NewAcct.Principle <= 0)
                throw new ArgumentOutOfRangeException("Principle", "Principle amount is not Valid");

            // if no settlment dates provided, at least consider the close date is settlment date
            if(SettlmentDates == null || SettlmentDates.Length <= 0)
            {
                SettlmentDates = new DEF_FIXRATE_ACCT_DATES[1];
                SettlmentDates[0] = new DEF_FIXRATE_ACCT_DATES();
                SettlmentDates[0].ACCT_DATE = NewAcct.CloseDate;
            }

            NewAcct.ACCT_TYPE = "FIXRATE";
            // if the OpenDate is backdated or current Business Date, set the Status to Active
            if (NewAcct.OpenDate <= Settings.GetCurrentBusinessDate())
            {
                NewAcct.STATUS_ID = 1;
                // TODO : shuold execute the Create Account Accounting Strcture 
            }
            else
            {
                NewAcct.STATUS_ID = 9; // Pending for Open Date
                // TODO : shuold execute the Open Account Accounting Strcture 
            }
            

            NewAcct.ACCT_NO = GenerateNewACCT_NO(NewAcct.ACCT_NO);
            if (true == string.IsNullOrEmpty(NewAcct.ACCT_NO))
                throw new ArgumentOutOfRangeException("ACCT_NO", "Invalid Account Number");

#if DEBUG
            decimal CalcInterest = 0;
            CalcInterest = CalcDayInterest(NewAcct, NewAcct.OpenDate, NewAcct.CloseDate.AddDays(-1));
#endif

            // 
            return FixedRateAccount_DAL.Create(NewAcct, SettlmentDates);
        }

        /// <summary>
        /// Interest Calculation Process for All Accounts
        /// </summary>
        static protected void InterestCalculationProcess(DateTime RunDate)
        {
            // TODO : Should process from last calculated date till the given date

            // Get All Fixed Rate Active Accounts
            DEF_FIXRATE_ACCT[] ActiveAccTs = FixedRateAccount_DAL.List(0);
            foreach(DEF_FIXRATE_ACCT FixedAcct in ActiveAccTs)
            {
                InterestCalculationProcess(FixedAcct, RunDate);
            }
        }




        /// <summary>
        /// Interest Calculation Process for sepcific Account
        /// </summary>
        static protected void InterestCalculationProcess(DEF_FIXRATE_ACCT Acct, DateTime RunDate)
        {
            // Escape Close Date 
            if (Acct.CloseDate == RunDate)
                return;
            PROC_FIXRATE_INTEREST LastAccrual = FixedRateAccount_DAL.GetLastActiveInterestProcess(Acct);

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

                NewInterestRecord
            }

        }

        /// <summary>
        /// Close Accounts Process , 
        /// Close all Mature anccounts 
        /// </summary>
        static protected void CloseAccountsProcess(DateTime RunDate)
        {
            DEF_FIXRATE_ACCT[] PFOAccts = FixedRateAccount_DAL.GetAllPendingForOpen();

            // TODO : shuold execute the Open Account Accounting Strcture 

            //foreach (DEF_CK_ACCT_ACCT_STRUCT ACCT_STRUCT in NewAcctStruct)
            foreach (DEF_FIXRATE_ACCT Acct in PFOAccts)
            {
                Acct.STATUS_ID = 1;

                FixedRateAccount_DAL.Update(Acct);
            }
        }


        /// <summary>
        /// Calc Interest for the given (From date, To Date) and Fiven account
        /// </summary>
        static protected decimal CalcDayInterest(DEF_FIXRATE_ACCT Acct, DateTime FromDate, DateTime ToDate)
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
        static protected decimal CalcDayInterest(DEF_FIXRATE_ACCT Acct, DateTime RunDate)
        {
            // TODO, currently only the 30/360 is supported, TODO support other accrual basis 
            decimal Daily = 0, Ret=0;

            if (Acct.Rate.HasValue)
            {
                Daily = Acct.Principle / 360;
                Ret = Daily * Acct.Rate.Value;
            }

            return Ret;
        }

        /// <summary>
        /// Open Accounts Process
        /// open all pending for Open Date Accounts, and Turn them to Active 
        /// </summary>
        static protected void OpenAccountsProcess(DateTime RunDate)
        {
            DEF_FIXRATE_ACCT[] PFOAccts = FixedRateAccount_DAL.GetAllPendingForOpen();

            // TODO : shuold execute the Open Account Accounting Strcture 

            //foreach (DEF_CK_ACCT_ACCT_STRUCT ACCT_STRUCT in NewAcctStruct)
            foreach (DEF_FIXRATE_ACCT Acct in PFOAccts)
            {
                Acct.STATUS_ID = 1;

                FixedRateAccount_DAL.Update(Acct);
            }
        }



        /// <summary>
        /// Generates the new Account number 
        /// </summary>
        static protected string GenerateNewACCT_NO(string stACCT_NO)
        {
            int nAcctNo = 0;
            string sReturn = string.Empty;

            if(string.IsNullOrEmpty(stACCT_NO)) 
            {
                stACCT_NO = FixedRateAccount_DAL.GetMaxCode();
                if(true == string.IsNullOrEmpty(stACCT_NO))
                     stACCT_NO = _CURRENT_ACCOUNT_NUM_FORMAT;
                nAcctNo = (int) int.Parse(stACCT_NO);
                nAcctNo ++;
                sReturn = _CURRENT_ACCOUNT_NUM_FORMAT + nAcctNo.ToString();
                int cToRemove = sReturn.Length - _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH;
                sReturn = sReturn.Remove(0,cToRemove);
            }
            else
            {
                if(stACCT_NO.Length > _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH)
                    sReturn = string.Empty; // ERROR
                else
                {
                    sReturn = _CURRENT_ACCOUNT_NUM_FORMAT + stACCT_NO.ToString();
                    int cToRemove = sReturn.Length - _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH;
                    sReturn = sReturn.Remove(0,cToRemove);
                }
            }

            return sReturn;
        }
    }
}
