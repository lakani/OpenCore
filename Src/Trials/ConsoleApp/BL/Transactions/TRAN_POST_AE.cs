using System.Collections.Generic;
using System.Linq;
using System;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL.Objects;



namespace SIS.OpenCore.BL.Transactions
{
    public partial class TRAN_POST_AE
    {

        static public Guid Post(TRAN_POST_AE_TYPE_PARAM[] ae_Param )        
        {
            string stBaseCurrency;
            DateTime MaxEffDt = DateTime.MinValue;
	        DateTime CRT_DT = DateTime.MinValue;

            // Get Base Currency
            stBaseCurrency = Settings.fn_OPT_GetBaseCurrency();
            if (string.IsNullOrEmpty(stBaseCurrency))
                return Guid.Empty;
            
            if(Retrive_GL_Info(ae_Param,stBaseCurrency) == false)
                return Guid.Empty;

            return new Guid();
        }

        /*
                Ensure that sum of CR = SUM of DR
	            select @SumOfCR = SUM(l.Acct_Amt) from @Legs l where UPPER (l.Acct_CR_DR) = 'CR'
	            select @SumOfDR = SUM(l.Acct_Amt) from @Legs l where UPPER (l.Acct_CR_DR) = 'DR'
        */
        static public bool sum_of_CR_Equal_SUM_of_DR(TRAN_POST_AE_TYPE_PARAM[] Legs, string stBaseCurr)
        {
            decimal  SumOfCR = 0,  @SumOfDR = 0;

            SumOfCR =   (from l in Legs
                        where l.Acct_CR_DR == "CR" && l.Acct_Curr == stBaseCurr
                        select l.Acct_Amt).Sum();

            SumOfDR =   (from l in Legs
                        where l.Acct_CR_DR == "DR" && l.Acct_Curr == stBaseCurr
                        select l.Acct_Amt).Sum();

            if (SumOfDR != SumOfCR)
                return false;
            else
                return true;
        }

        // Ensure that all legs are within the same company
        static public bool Retrive_GL_Info(TRAN_POST_AE_TYPE_PARAM[] Legs, string stBaseCurr )
        {
            foreach(TRAN_POST_AE_TYPE_PARAM Leg in Legs)
            {
                if (Leg.GL == true)
                    Leg.GL_Info = GL.fn_GetGLInfo(Leg.Acct_No, stBaseCurr);
                if (Leg.GL == true && Leg.GL_Info == null)
                    return false;
            }

            return true;
        }



    }
}