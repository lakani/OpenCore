using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Server.BL.Process;
using SIS.OpenCore.Server.BL;
using SIS.OpenCore.Shared.Model;
using DAL = SIS.OpenCore.DAL;

namespace SIS.OpenCore.Server.BL.Objects
{
    public partial class FixedRateAccount
    {

        static protected short _FIXED_RATE_NUM_FORMAT_LENGTH = 15;
        static protected string _FIXED_RATE_NUM_FORMAT = "000000000000000";

        /// <summary>
        /// create new Fixed Rate account for the given CIF
        /// </summary>
        public static string Create(DEF_FIXRATE_ACCT NewAcct, DEF_FIXRATE_ACCT_DATES[] SettlmentDates)
        {
            // TODO : check using Repository
            // if (false == Company.ValidateExists(NewAcct.CompanyNo))
            //     throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");

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
            CalcInterest = FixedRateAccountProc.CalcDayInterest(NewAcct, NewAcct.OpenDate, NewAcct.CloseDate);
#endif

            // 
            return DAL.FixedRateAccount.Create(NewAcct, SettlmentDates);
        }

        
        

        /// <summary>
        /// Close Accounts Process , 
        /// Close all Mature anccounts 
        /// </summary>
        static protected void CloseAccountsProcess(DateTime RunDate)
        {
            DEF_FIXRATE_ACCT[] PFOAccts = DAL.FixedRateAccount.GetAllPendingForOpen();

            // TODO : shuold execute the Open Account Accounting Strcture 

            //foreach (DEF_CK_ACCT_ACCT_STRUCT ACCT_STRUCT in NewAcctStruct)
            foreach (DEF_FIXRATE_ACCT Acct in PFOAccts)
            {
                Acct.STATUS_ID = 1;

                DAL.FixedRateAccount.Update(Acct);
            }
        }



        /// <summary>
        /// Open Accounts Process
        /// open all pending for Open Date Accounts, and Turn them to Active 
        /// </summary>
        static protected void OpenAccountsProcess(DateTime RunDate)
        {
            DEF_FIXRATE_ACCT[] PFOAccts = DAL.FixedRateAccount.GetAllPendingForOpen();

            // TODO : shuold execute the Open Account Accounting Strcture 

            //foreach (DEF_CK_ACCT_ACCT_STRUCT ACCT_STRUCT in NewAcctStruct)
            foreach (DEF_FIXRATE_ACCT Acct in PFOAccts)
            {
                Acct.STATUS_ID = 1;

                DAL.FixedRateAccount.Update(Acct);
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
                stACCT_NO = DAL.FixedRateAccount.GetMaxCode();
                if(true == string.IsNullOrEmpty(stACCT_NO))
                     stACCT_NO = _FIXED_RATE_NUM_FORMAT;
                nAcctNo = (int) int.Parse(stACCT_NO);
                nAcctNo ++;
                sReturn = _FIXED_RATE_NUM_FORMAT + nAcctNo.ToString();
                int cToRemove = sReturn.Length - _FIXED_RATE_NUM_FORMAT_LENGTH;
                sReturn = sReturn.Remove(0,cToRemove);
            }
            else
            {
                if(stACCT_NO.Length > _FIXED_RATE_NUM_FORMAT_LENGTH)
                    sReturn = string.Empty; // ERROR
                else
                {
                    sReturn = _FIXED_RATE_NUM_FORMAT + stACCT_NO.ToString();
                    int cToRemove = sReturn.Length - _FIXED_RATE_NUM_FORMAT_LENGTH;
                    sReturn = sReturn.Remove(0,cToRemove);
                }
            }

            return sReturn;
        }
    }
}
