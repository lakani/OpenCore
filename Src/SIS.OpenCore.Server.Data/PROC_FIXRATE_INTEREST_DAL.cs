using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Server.Data.Context;

namespace SIS.OpenCore.Server.Data.TODO
{
    public partial class PROC_FIXRATE_INTEREST_DAL
    {
        /// <summary>
        /// Get Last Active Interest Calculation Process for the Given Fixed Account
        /// </summary>
        // static public PROC_FIXRATE_INTEREST GetLastActiveInterestProcess(DEF_FIXRATE_ACCT Acct)
        // {
        //     OpenCoreContext db = new OpenCoreContext();
        //     return ((from p in db.PROC_FIXRATE_INTEREST
        //              where p.STATUS_ID == 1 && p.CIF_NO == Acct.CIF_NO && p.ACCT_NO == Acct.ACCT_NO
        //              orderby p.TO_DATE descending
        //              select p).FirstOrDefault());
        // }

        /// <summary>
        /// Insert new Fixed Rate Account into the Database
        /// </summary>
        // static public int Create(PROC_FIXRATE_INTEREST NewRecord)
        // {
        //     PROC_FIXRATE_INTEREST NewRecord_EL = new PROC_FIXRATE_INTEREST();
        //     OpenCoreContext db = new OpenCoreContext();

        //     NewRecord_EL.FROM_DATE = NewRecord.FROM_DATE;
        //     NewRecord_EL.TO_DATE = NewRecord.TO_DATE;
        //     NewRecord_EL.PRINCIPLE_AMT = NewRecord.PRINCIPLE_AMT;
        //     NewRecord_EL.STATUS_ID = NewRecord.STATUS_ID;
        //     NewRecord_EL.ACCT_NO = NewRecord.ACCT_NO;
        //     NewRecord_EL.CIF_NO = NewRecord.CIF_NO;
        //     NewRecord_EL.CALC_INTEREST_AMT = NewRecord.CALC_INTEREST_AMT;

        //     db.PROC_FIXRATE_INTEREST.Add(NewRecord_EL);
        //     return db.SaveChanges();
        // }
    }
}
