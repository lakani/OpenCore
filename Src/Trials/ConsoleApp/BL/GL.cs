using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL
{
    public partial class GL
    {
            //@LEDGERNO_OUT	nvarchar(15)	OUTPUT,
            // @CompanyNo		int,
            // @Zone			int,
            // @BranchNo		int,
            // @SectorNo		int,
            // @DepNo			int,
            // @UNITNO			int,
            // @NATURE			int,
            // @LEDGERNO		nvarchar(MAX) = null,
            // @TotallingGL	nvarchar(100) = null,
            // @POSTINGLEVEL	int = null,
            // @CURR			nvarchar(4) = null, 
            // @COMMENTS		nvarchar(200) = null,
            // @EFFECTIVE_DT	datetime = null,
            // @REFERENCE		nvarchar(MAX) = null
         static public string Add_GL (
                DateTime    EFFECTIVE_DT ,
                short       CompanyNo,
                byte        NATURE,
                byte        nZone = 0,
                short       BranchNo = 0,
                byte        SectorNo = 0,
                byte        DepNo = 0,
                byte        UNITNO = 0,
                string      CURR = "" ,
                byte        POSTINGLEVEL = 1,
                string      LEDGERNO = "",
                string      TotallingGL = "",
                string      COMMENTS = "",
                string      REFERENCE	=""
         )      
         {
            //-- if not supplied , assume its the base currency
            if (String.IsNullOrEmpty(CURR))
                CURR = Settings.fn_OPT_GetBaseCurrency();
            
            //-- if not supplied , assume its current bussiness date
            if(EFFECTIVE_DT <= DateTime.MinValue || EFFECTIVE_DT >= DateTime.MaxValue )
                EFFECTIVE_DT = Settings.fn_GetCurrentBusinessDate();

            //-- check paramters
                //PRINT 'Checking DEF_Currency Table'
                if(!Currency.ValidateExists(CURR))
                    return "";
                //PRINT 'Checking Company in DEF_Company Table'
                if(!Company.ValidateExists(CompanyNo))
                    return "";
                //PRINT 'Checking DEF_Zone Table'
                if(nZone != 0)
                    if(!Zone.ValidateExists((byte)nZone))
                        return "";
                //PRINT 'Checking DEF_Branch Table'
                if(BranchNo != 0)
                    if(!Branch.ValidateExists((short)BranchNo))
                        return "";
                //PRINT 'Checking DEF_Sector Table'
                if (SectorNo != 0)
                    if ( ! Sector.ValidateExists((byte) SectorNo))
                        return "";
                //PRINT 'Checking DEF_Dep Table'
                if(DepNo != 0)
                    if( ! Dep.ValidateExists((byte) DepNo) )
                        return "";
                //PRINT 'Checking DEF_Unit Table'
                if(UNITNO != 0)
                    if( ! Unit.ValidateExists((byte) UNITNO) )
                        return "";

            
            // Getnerate the new Ledger number
            if(! String.IsNullOrEmpty(LEDGERNO) )
            {
                byte cGLFormatDigitsNum = Settings.fn_OPT_GetGLFormatDigitsNum();

                // ensure that @LEDGERNO length equel the GLFormatDigitsNum if @LEDGERNO is provided
                if(LEDGERNO.Length > cGLFormatDigitsNum)
                    return "";
            }
            else
            {
                string sMaxLedger = GL.GetMaxLedger(CompanyNo, (byte)NATURE, CURR, nZone, BranchNo, 
                                                    SectorNo, DepNo, UNITNO, POSTINGLEVEL);
                int nMax;
                nMax = int.Parse(sMaxLedger);
                nMax = nMax + 1;
                sMaxLedger = Settings.fn_OPT_GetGLFormatDigits() + nMax.ToString();
                int cToRemove = sMaxLedger.Length - Settings.fn_OPT_GetGLFormatDigitsNum();
                LEDGERNO = sMaxLedger.Remove(0, cToRemove);
            }

            #region TotallingGL
                // in General , if the Totalling GL is not correct, return error
            if( ! String.IsNullOrEmpty(TotallingGL) )
            {
                if (TotallingGL.Length > Settings.fn_OPT_GetGLMAXLength())
                    return "";

                DEF_GL TotallingGLObj = GL.fn_GetGLInfo(TotallingGL, CURR);
                if(TotallingGLObj == null)
                    return "";
                else
                {
                    if( TotallingGLObj.CompanyNo != CompanyNo || TotallingGLObj.Nature != NATURE ||
                        TotallingGLObj.CURR != CURR || TotallingGLObj.PostingLevel != POSTINGLEVEL) 
                            return "";
                }
            }
            #endregion
            
            #region Check_if_Exists
            
            if (ValidateExists(CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, UNITNO, POSTINGLEVEL, LEDGERNO) == true)
                return "";
                
            #endregion

            #region Insert_into_Database

            DEF_GL newGLTobeInserted = new DEF_GL();
            newGLTobeInserted.EFFECTIVE_DT = EFFECTIVE_DT;
            newGLTobeInserted.CompanyNo = CompanyNo;
            newGLTobeInserted.Nature = NATURE;
            newGLTobeInserted.CURR = CURR;
            newGLTobeInserted.Zone = nZone;
            newGLTobeInserted.BranchNo = BranchNo;
            newGLTobeInserted.SectorNo = SectorNo;
            newGLTobeInserted.DepNo = DepNo;
            newGLTobeInserted.UnitNO = UNITNO;
            newGLTobeInserted.PostingLevel = POSTINGLEVEL;
            newGLTobeInserted.LedgerNO = LEDGERNO;
            newGLTobeInserted.STATUS = 1;
            newGLTobeInserted.COMMENTS = COMMENTS;
            newGLTobeInserted.TotallingGL = TotallingGL;

            OpenCoreContext db = new OpenCoreContext();
            db.DEF_GL.Add(newGLTobeInserted);
            db.SaveChanges();
            #endregion
           
            return newGLTobeInserted.LedgerNO;
        }

        public static bool ValidateExists (short nCompany, byte nNature, string CurrISO, byte nZone, short nBranch, byte nSector,
                                          byte nDep, byte nUNITNO, byte nPOSTINGLEVEL , string Ledger)
        {
            DEF_GL  gl = new DEF_GL() {
                CompanyNo = nCompany,
                Nature = nNature,
                CURR = CurrISO, 
                Zone = nZone,
                BranchNo = nBranch,
                SectorNo = nSector,
                DepNo = nDep,
                UnitNO = nUNITNO,
                PostingLevel = nPOSTINGLEVEL,
                LedgerNO = Ledger
            };

            gl = fn_GetGLInfo(gl, gl.CURR);
            if(gl != null)
                return true;

            return false;
        }

        public static string fn_String_BuildGL( int Zone,  int CompanyNo,  int BranchNo,  int SectorNo,  int DepNo,  
                                                int UnitNO, string LedgerNO)
        {
            // RIGHT('00'+ CONVERT(VARCHAR,@Zone),2) + '-' + 
            // RIGHT('00'+ CONVERT(VARCHAR,@CompanyNo),2) + '-' + 
            // RIGHT('00'+ CONVERT(VARCHAR,@BranchNo),2) + '-' + 
            // RIGHT('00'+ CONVERT(VARCHAR,@SectorNo),2) + '-' + 
            // RIGHT('00'+ CONVERT(VARCHAR,@DepNo),2) + '-' + 
            // RIGHT('00'+ CONVERT(VARCHAR,@UnitNO),2) + '-' +
            // CAST(@LedgerNO as nvarchar(MAX))

            string stReturn = string.Empty;

            stReturn += ("00" + Zone.ToString()).Substring(0,2) + "-";
            stReturn += ("00" + CompanyNo.ToString()).Substring(0,2) + "-";
            stReturn += ("00" + BranchNo.ToString()).Substring(0,2) + "-";
            stReturn += ("00" + SectorNo.ToString()).Substring(0,2) + "-";
            stReturn += ("00" + DepNo.ToString()).Substring(0,2) + "-";
            stReturn += ("00" + UnitNO.ToString()).Substring(0,2) + "-";
            stReturn += ("00" + LedgerNO.ToString()).Substring(0,5) ;

            return stReturn;
        }


        public static string GetMaxLedger(int nCompany, byte nNature, string CurrISO, int nZone, int nBranch, int nSector,
                                          int nDep, int nUNITNO, int nPOSTINGLEVEL )
        {
            OpenCoreContext db = new OpenCoreContext();

            //GL.CompanyNo = @CompanyNo AND GL.Zone = @Zone AND Gl.BranchNo = @BranchNo AND Gl.SectorNo = @SectorNo)

            // TODO : Add more Conditions
            string stMaxLedger =    (from g in db.DEF_GL
                                    where ( (nCompany > 0 && g.CompanyNo == nCompany) || 
                                            (nNature > 0 && g.Nature == nNature)  )
                                    select g.LedgerNO).Max();
            if(string.IsNullOrEmpty(stMaxLedger))
                stMaxLedger = Settings.fn_OPT_GetGLFormatDigits();

            return stMaxLedger;
        }

        public static DEF_GL fn_GetGLInfo(DEF_GL gL, string stCURR)
        {
            OpenCoreContext db = new OpenCoreContext();
            //where		GLTbl.LedgerNO = @LedgerNO and GLTbl.Zone = @ZoneNo AND	
            //          GLTbl.CompanyNo = @CompanyNo and GLTbl.BranchNo = @BranchNo AND 
            //          GLTbl.CURR = @ISOCurr and GLTbl.SectorNo = @SectorNo and 
			//          GLTbl.DepNo = @DepNo and GLTbl.UnitNO = @UnitNO 
			
            var RetGL = (from g in db.DEF_GL
                        where   g.LedgerNO == gL.LedgerNO && g.Zone == gL.Zone &&
                                g.CompanyNo == gL.CompanyNo && g.BranchNo == gL.BranchNo &&
                                g.CURR == stCURR && g.SectorNo == gL.SectorNo && 
                                g.DepNo == gL.DepNo && g.UnitNO == gL.UnitNO
                        select g).FirstOrDefault();
                        

            return RetGL;
        }
        public static DEF_GL fn_GetGLInfo(string stGL, string stCURR)
        {
            OpenCoreContext db = new OpenCoreContext();

            DEF_GL RetGL = GL.fn_String_ParseGL(stGL);
            
            //where		GLTbl.LedgerNO = @LedgerNO and GLTbl.Zone = @ZoneNo AND	
            //          GLTbl.CompanyNo = @CompanyNo and GLTbl.BranchNo = @BranchNo AND 
            //          GLTbl.CURR = @ISOCurr and GLTbl.SectorNo = @SectorNo and 
			//          GLTbl.DepNo = @DepNo and GLTbl.UnitNO = @UnitNO 
            return fn_GetGLInfo(RetGL, stCURR);
        }

        public static DEF_GL fn_String_ParseGL(string stGL)
        {
            DEF_GL RetGL = new DEF_GL();

            // SUBSTRING(@GL,1, 2)		'Zone',									-- Zone
            // SUBSTRING(@GL,4, 2)		'CompanyNo',							-- CompanyNo
            // SUBSTRING(@GL,7, 2)		'BranchNo',								-- BranchNo
            // SUBSTRING(@GL,10, 2)		'SectorNo',								-- SectorNo
            // SUBSTRING(@GL,13, 2)	'DepNo'	,								-- DepNo
            // SUBSTRING(@GL,16, 2)	'UnitNO',								-- UnitNO
            // SUBSTRING(@GL,19, dbo.fn_OPT_GetGLFormatDigitsNum()) 'LedgerNO'	-- LedgerNO

            RetGL.Zone = (byte)int.Parse(stGL.Substring(0, 2));
            RetGL.CompanyNo = (short)int.Parse(stGL.Substring(3, 2));
            RetGL.BranchNo = (byte)int.Parse(stGL.Substring(6, 2));
            RetGL.SectorNo = (byte)int.Parse(stGL.Substring(9, 2));
            RetGL.DepNo = (byte)int.Parse(stGL.Substring(12, 2));
            RetGL.UnitNO = (byte)int.Parse(stGL.Substring(15, 2));
            RetGL.LedgerNO = stGL.Substring(18, Settings.fn_OPT_GetGLFormatDigitsNum());

            return RetGL;
        }
    }
}