using System.Collections.Generic;
using System.Linq;
using System;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL.Objects;



namespace SIS.OpenCore.BL.Transactions
{
    public partial class TRAN_POST_AE
    {

        static protected bool RefExistsAndActive(Guid InqRef)
        {
            OpenCoreContext db = new OpenCoreContext();
            int Exists =    (from t in db.TRN_LEGS
                            where t.Ref == InqRef && t.STATUS_ID == 1
                            select t.Ref).Count();
            if(Exists> 0)
                return true;
            return  false;
        }

        static public bool Reverse(Guid Ref)
        {
            OpenCoreContext db = new OpenCoreContext();

            if(RefExistsAndActive(Ref) == false)
                throw new ArgumentOutOfRangeException("Ref", 
                "Invalid Reference number or has been reversed before");

            var Legs =  from l in db.TRN_LEGS
                        where l.Ref == Ref && l.STATUS_ID == 1
                        select l;
            
            var newLegs = CopyLegsForReverse(Legs.ToArray());
            
            foreach (TRAN_POST_AE_TYPE_PARAM l in newLegs)
            {
                if(l.Acct_CR_DR == "CR" )
                    l.Acct_CR_DR = "DR";
                else
                    l.Acct_CR_DR = "CR";
            }
            Post(newLegs.ToArray(), Ref);

            foreach (TRN_LEGS l in Legs)
            {
                l.STATUS_ID = 2; // 2 is Reversed
            }
            db.SaveChanges();

            

            return true;
        }

        static protected List<TRAN_POST_AE_TYPE_PARAM> CopyLegsForReverse(TRN_LEGS[] Legs)
        {
            List<TRAN_POST_AE_TYPE_PARAM> ARR = new List<TRAN_POST_AE_TYPE_PARAM>();
            
            foreach (TRN_LEGS l in Legs)
            {
                ARR.Add (new TRAN_POST_AE_TYPE_PARAM{   Acct_CR_DR = l.Acct_CR_DR , 
                                                        Acct_No = l.Acct_No,
                                                        GL = (bool)l.GL, 
                                                        Acct_Amt = (decimal)l.Acct_Amt,
                                                        Acct_Curr = l.Acct_Curr,
                                                        Acct_Description = "Rev : " + l.Ref,
                                                        EffDt=DateTime.Today});

            }
            return ARR;
        }

        static public Guid Post(TRAN_POST_AE_TYPE_PARAM[] ae_Param , Guid RelatedRef)        
        {
            string      stBaseCurrency;
            DateTime    MaxEffDt = DateTime.MinValue;
	        DateTime    CRT_DT = DateTime.MinValue;
            Guid        RetGUID = Guid.Empty;
            

            // Get Base Curren\cy
            stBaseCurrency = Settings.fn_OPT_GetBaseCurrency();
            if (string.IsNullOrEmpty(stBaseCurrency))
                return Guid.Empty;
            
            // get Current Bussiness date
            MaxEffDt = Settings.fn_GetCurrentBusinessDate();

            // get Today
            CRT_DT = DateTime.Now;

            if (CRT_DT.Date > MaxEffDt.Date )
                return Guid.Empty;
            
            // Get All Legs GLs information 
            // ensure that all Gls got the supplied currency 
            if(Retrive_GL_Info(ae_Param,stBaseCurrency) == false)
                return Guid.Empty;

            if(Validation_Sum_of_CR_Equal_Sum_of_DR(ae_Param, stBaseCurrency) == false)
                return Guid.Empty;

            if(Validation_All_Legs_Within_Same_Company(ae_Param) == false)
                return Guid.Empty;

            if(Validation_All_Legs_Backdated(ae_Param, MaxEffDt ) == false)
                return Guid.Empty;

            // Generate the new Refrerence
            RetGUID = Guid.NewGuid();
            short   Sequence = 1;
            OpenCoreContext db = new OpenCoreContext();
    
            foreach(TRAN_POST_AE_TYPE_PARAM Leg in ae_Param)
            {
                TRN_LEGS    trn_LEGSNewObject = new TRN_LEGS();
                
                trn_LEGSNewObject.Acct_Amt          = Leg.Acct_Amt;
                trn_LEGSNewObject.Acct_CR_DR        = Leg.Acct_CR_DR; 
                trn_LEGSNewObject.Acct_Curr         = Leg.Acct_Curr;
                trn_LEGSNewObject.Acct_Description  = Leg.Acct_Description;
                trn_LEGSNewObject.Acct_No           = Leg.Acct_No;
                trn_LEGSNewObject.Balance_Before    = GetLastBalance(Leg.Acct_No, Leg.GL, Leg.Acct_Curr);
                trn_LEGSNewObject.Balance_After     =  AccountingMisc.NUM_ACT_CR_DR
                                                            ((decimal)trn_LEGSNewObject.Balance_Before, 
                                                            Leg.Acct_Amt, 
                                                            Leg.GL_Info.Nature,
                                                            Leg.Acct_CR_DR);
                trn_LEGSNewObject.CHANNEL_ID        = 1;
                trn_LEGSNewObject.CREATE_DT         = CRT_DT;
                trn_LEGSNewObject.EffDt             = MaxEffDt;
                trn_LEGSNewObject.EMP_ID            = 1;
                trn_LEGSNewObject.GL                = Leg.GL;
                trn_LEGSNewObject.Ref               = RetGUID;
                trn_LEGSNewObject.Sequence          = Sequence;
                trn_LEGSNewObject.STATUS_ID         = 1;
                trn_LEGSNewObject.Related_Ref       = RelatedRef;

                db.TRN_LEGS.Add(trn_LEGSNewObject);
                db.SaveChanges();

                Sequence ++;
            }
            
            return RetGUID;
        }

        static protected decimal GetLastBalance(string Acct_No, bool isGL, string Acct_Curr)
        {
            // TODO : Seperate a call, one for GL and another for Account
            if(isGL)
                return GL.GetLastBalance( Acct_No, Acct_Curr);
            else
                return GL.GetLastBalance( Acct_No, Acct_Curr);

        }

        /*
                Ensure that sum of CR = SUM of DR
	            select @SumOfCR = SUM(l.Acct_Amt) from @Legs l where UPPER (l.Acct_CR_DR) = 'CR'
	            select @SumOfDR = SUM(l.Acct_Amt) from @Legs l where UPPER (l.Acct_CR_DR) = 'DR'
        */
        static protected bool Validation_Sum_of_CR_Equal_Sum_of_DR(TRAN_POST_AE_TYPE_PARAM[] Legs, string stBaseCurr)
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

        static protected bool Validation_All_Legs_Within_Same_Company(TRAN_POST_AE_TYPE_PARAM[] Legs)
        {
            short[] companyArr =    (from l in Legs
                                    select l.GL_Info.CompanyNo).Distinct().ToArray();
            
            if(companyArr.Length > 1)
                return false;
            return true;
        }

        static protected  bool Validation_All_Legs_Backdated(TRAN_POST_AE_TYPE_PARAM[] Legs, DateTime MaxEffDt )
        {
            int cLegsFuture =   (from l in Legs
                                where l.EffDt > MaxEffDt
                                select l.Acct_No).Count();
            
            if (cLegsFuture > 0 )
                return false;
            return true;
        }

        // Ensure that all legs are within the same company
        static protected bool Retrive_GL_Info(TRAN_POST_AE_TYPE_PARAM[] Legs, string stBaseCurr )
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