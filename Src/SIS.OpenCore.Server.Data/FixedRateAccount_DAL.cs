using System;
using System.Linq;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Server.Data.Context;
using System.Collections.Generic;

namespace SIS.OpenCore.Server.Data
{
    public partial class FixedRateAccount
    {
        /// <summary>
        /// Return the MAX Code
        /// </summary>
        static public string GetMaxCode()
        {
            OpenCoreContext db = new OpenCoreContext();
            string stMaxCode = (from r in db.DEF_FIXRATE_ACCT
                                select r.ACCT_NO).Max();
            return stMaxCode;
        }

        /// <summary>
        /// update the Account in the Database
        /// </summary>
        static public bool Update (DEF_FIXRATE_ACCT Acct)
        {
            OpenCoreContext db = new OpenCoreContext();

            // TODO : review this function if needed
            return true;
        }


        /// <summary>
        /// Get All Active Accounts for the requested count of records, if Zero is passed then all records will be retrived 
        /// </summary>
        static public DEF_FIXRATE_ACCT[] List(string CIF_NO, string ISO, short cRecordsPerPage)
        {
            OpenCoreContext db = new OpenCoreContext();
            var Query = from l in db.DEF_FIXRATE_ACCT
                        where l.STATUS_ID == 1
                        select l;

            if (false == String.IsNullOrEmpty(CIF_NO))
                Query = Query.Where(l => l.CIF_NO == CIF_NO);

            if (false == String.IsNullOrEmpty(ISO))
                Query = Query.Where(l => l.Currency== ISO);

            Query.OrderBy(l => l.OpenDate);

            if (cRecordsPerPage == 0)
                return Query.ToArray();
            else
                return Query.Take(cRecordsPerPage).ToArray();
        }

        /// <summary>
        /// Get All pending for Open Accounts
        /// </summary>
        static public DEF_FIXRATE_ACCT[] GetAllPendingForOpen()
        {
            //DEF_FIXRATE_ACCT[] PFOAccts = new DEF_FIXRATE_ACCT[2];
            OpenCoreContext db = new OpenCoreContext();
            return (from r in db.DEF_FIXRATE_ACCT
                    where r.STATUS_ID == 9
                    select r).ToArray();
        }

        /// <summary>
        /// Insert new Fixed Rate Account into the Database
        /// </summary>
        static public string Create(DEF_FIXRATE_ACCT NewAcct, DEF_FIXRATE_ACCT_DATES[] SettlmentDates)
        {
            DEF_FIXRATE_ACCT NewAcct_EL = new DEF_FIXRATE_ACCT();
            OpenCoreContext db = new OpenCoreContext();

            NewAcct_EL.AccrualBasis = NewAcct.AccrualBasis;
            NewAcct_EL.ACCT_NO = NewAcct.ACCT_NO;
            NewAcct_EL.ACCT_CLASS = NewAcct.ACCT_CLASS;
            NewAcct_EL.ACCT_TYPE = NewAcct.ACCT_TYPE;
            NewAcct_EL.CIF_NO = NewAcct.CIF_NO;
            NewAcct_EL.CloseDate = NewAcct.CloseDate;
            NewAcct_EL.CompanyNo = NewAcct.CompanyNo;
            NewAcct_EL.CreateDate = NewAcct.CreateDate;
            NewAcct_EL.CSP_Code = NewAcct.CSP_Code;
            NewAcct_EL.Currency = NewAcct.Currency;
            NewAcct_EL.Description = NewAcct.Description;
            NewAcct_EL.IBAN = NewAcct.IBAN;
            NewAcct_EL.OpenDate = NewAcct.OpenDate;
            NewAcct_EL.Principle = NewAcct.Principle;
            NewAcct_EL.Rate = NewAcct.Rate;
            NewAcct_EL.ReferenceACCT = NewAcct.ReferenceACCT;
            NewAcct_EL.ReferenceOrg = NewAcct.ReferenceOrg;
            NewAcct_EL.Title = NewAcct.Title;
            NewAcct_EL.STATUS_ID = NewAcct.STATUS_ID;

            db.DEF_FIXRATE_ACCT.Add(NewAcct_EL);
            db.SaveChanges();

            foreach (DEF_FIXRATE_ACCT_DATES SettlmentDate in SettlmentDates)
            {
                DEF_FIXRATE_ACCT_DATES SettlmentDate_EL = new DEF_FIXRATE_ACCT_DATES();

                SettlmentDate_EL.ACCT_DATE = SettlmentDate.ACCT_DATE;
                SettlmentDate_EL.ACCT_NO = NewAcct_EL.ACCT_NO;
                SettlmentDate_EL.DEF_ACCT_ID = NewAcct_EL.DEF_ACCT_ID;

                db.DEF_FIXRATE_ACCT_DATES.Add(SettlmentDate_EL);
                db.SaveChanges();
            }

            return NewAcct.ACCT_NO;
        }
    }
}
