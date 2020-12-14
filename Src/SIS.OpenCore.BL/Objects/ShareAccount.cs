﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.BL.Process;
using SIS.OpenCore.Model;
using DAL = SIS.OpenCore.DAL;

namespace SIS.OpenCore.BL.Objects
{
    public partial class ShareAccount
    {
        static protected byte _SHARE_ACCOUNT_NUM_FORMAT_LENGTH = 15;
        static protected string _SHARE_ACCOUNT_NUM_FORMAT = "000000000000000";

        static public DEF_SHARE_ACCT Find(DEF_SHARE_ACCT toFind)
        {
            return DAL.ShareAccount.Find(toFind);
        }

        public static string Create(DEF_SHARE_ACCT NewAcct)
        {
            if (false == Company.ValidateExists(NewAcct.CompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");

            if (false == Currency.ValidateExists(NewAcct.Currency))
                throw new ArgumentOutOfRangeException("Currency", "Currency doesn't Exists");

            if (false == Cif.ValidateExists(NewAcct.CIF_NO))
                throw new ArgumentOutOfRangeException("CIF_NO", "CIF_NO doesn't Exists");

            if(null != Find(NewAcct))
                throw new ArgumentOutOfRangeException("NewAcct", "Already Exists");

            NewAcct.ACCT_TYPE = "SHARE";
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

            // 
            return DAL.ShareAccount.Create(NewAcct);
        }

        static protected string GenerateNewACCT_NO(string stACCT_NO)
        {
            int nAcctNo = 0;
            string sReturn = string.Empty;

            if (string.IsNullOrEmpty(stACCT_NO))
            {
                stACCT_NO = DAL.ShareAccount.GetMaxCode();
                if (true == string.IsNullOrEmpty(stACCT_NO))
                    stACCT_NO = _SHARE_ACCOUNT_NUM_FORMAT;
                nAcctNo = (int)int.Parse(stACCT_NO);
                nAcctNo++;
                sReturn = _SHARE_ACCOUNT_NUM_FORMAT + nAcctNo.ToString();
                int cToRemove = sReturn.Length - _SHARE_ACCOUNT_NUM_FORMAT_LENGTH;
                sReturn = sReturn.Remove(0, cToRemove);
            }
            else
            {
                if (stACCT_NO.Length > _SHARE_ACCOUNT_NUM_FORMAT_LENGTH)
                    sReturn = string.Empty; // ERROR
                else
                {
                    sReturn = _SHARE_ACCOUNT_NUM_FORMAT + stACCT_NO.ToString();
                    int cToRemove = sReturn.Length - _SHARE_ACCOUNT_NUM_FORMAT_LENGTH;
                    sReturn = sReturn.Remove(0, cToRemove);
                }
            }

            return sReturn;
        }
    }
}
