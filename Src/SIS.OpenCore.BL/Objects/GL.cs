using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Model;
using System.Linq;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL;
using SIS.OpenCore.Shared.Extensions;

namespace SIS.OpenCore.BL.Objects
{
    public partial class GL
    {
        static Segment[] _segments = new Segment[] {   
            new Segment { Type = 1,   Name = "Nature",          DigitsValue = "#",      DigitsLength = 1},
            new Segment { Type = 2,   Name = "Zone",            DigitsValue = "##",     DigitsLength = 2},
            new Segment { Type = 3,   Name = "CompanyNo",       DigitsValue = "##",     DigitsLength = 2},
            new Segment { Type = 4,   Name = "BranchNo",        DigitsValue = "####",   DigitsLength = 4},
            new Segment { Type = 5,   Name = "SectorNo",        DigitsValue = "##",     DigitsLength = 2},
            new Segment { Type = 6,   Name = "DepNo",           DigitsValue = "##",     DigitsLength = 2},
            new Segment { Type = 7,   Name = "UnitNo",          DigitsValue = "##",     DigitsLength = 2},
            new Segment { Type = 8,   Name = "ProductNo",       DigitsValue = "####",   DigitsLength = 4},
            new Segment { Type = 9,   Name = "PostingLevel",    DigitsValue = "#",      DigitsLength = 1},
            new Segment { Type = 10,  Name = "LedgerNo",        DigitsValue = "######", DigitsLength = 6}};

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
                short       ProductNo = 0,
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
            if (string.IsNullOrEmpty(CURR))
                throw new Exception("fn_OPT_GetBaseCurrency can’t retrieve base currency");
            
            //-- if not supplied , assume its current bussiness date
            if(EFFECTIVE_DT <= DateTime.MinValue || EFFECTIVE_DT >= DateTime.MaxValue )
                EFFECTIVE_DT = Settings.fn_GetCurrentBusinessDate();

            //-- check paramters
                //PRINT 'Checking DEF_Currency Table'
                if(!Currency.ValidateExists(CURR))
                    return string.Empty;
                //PRINT 'Checking Company in DEF_Company Table'
                if(!Company.ValidateExists(CompanyNo))
                    throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");
                //PRINT 'Checking DEF_Zone Table'
                if(nZone != 0)
                    if(!Zone.ValidateExists((byte)nZone))
                        throw new ArgumentOutOfRangeException("nZone", "Zone Number doesn't Exists");
                //PRINT 'Checking DEF_Branch Table'
                if(BranchNo != 0)
                    if(!Branch.ValidateExists((short)BranchNo))
                        throw new ArgumentOutOfRangeException("BranchNo", "Branch Number doesn't Exists");
                //PRINT 'Checking DEF_Sector Table'
                if (SectorNo != 0)
                    if ( ! Sector.ValidateExists((byte) SectorNo))
                        throw new ArgumentOutOfRangeException("SectorNo", "Sector Number doesn't Exists");
                //PRINT 'Checking DEF_Dep Table'
                if(DepNo != 0)
                    if( ! Dep.ValidateExists((byte) DepNo) )
                        throw new ArgumentOutOfRangeException("DepNo", "Department Number doesn't Exists");
                //PRINT 'Checking DEF_Unit Table'
                if(UNITNO != 0)
                    if( ! Unit.ValidateExists((byte) UNITNO) )
                        throw new ArgumentOutOfRangeException("UNITNO", "Unit Number doesn't Exists");

            
            // Generate the new Ledger number
            if(! String.IsNullOrEmpty(LEDGERNO) )
            {
                byte cGLFormatDigitsNum = Settings.fn_OPT_GetGLFormatDigitsNum();

                // ensure that @LEDGERNO length equel the GLFormatDigitsNum if @LEDGERNO is provided
                //if(LEDGERNO.Length > cGLFormatDigitsNum)
                  //  throw new ArgumentOutOfRangeException("LEDGERNO", "Ledger number Length is greater than Digits Length");
            }
            else
            {
                // TODO
                //string sMaxLedger = GL.GetMaxLedger(CompanyNo, (byte)NATURE, CURR, nZone, BranchNo, 
                //                                    SectorNo, DepNo, UNITNO, ProductNo, POSTINGLEVEL);
                string sMaxLedger = "";
                int nMax;
                nMax = int.Parse(sMaxLedger);
                nMax = nMax + 1;
                sMaxLedger = Settings.fn_OPT_GetGLFormatDigits() + nMax.ToString();
                int cToRemove = sMaxLedger.Length - Settings.fn_OPT_GetGLFormatDigitsNum();
                //TODO
                //LEDGERNO = sMaxLedger.Remove(0, cToRemove);
            }

            #region TotallingGL
                // in General , if the Totalling GL is not correct, return error
            if( ! String.IsNullOrEmpty(TotallingGL) )
            {
                if (TotallingGL.Length > Settings.fn_OPT_GetGLMAXLength())
                    throw new ArgumentOutOfRangeException("TotallingGL", "Totalling Ledger number Length is greater than Digits Length");

                DEF_GL TotallingGLObj = GL.fn_GetGLInfo(TotallingGL, CURR);
                if(TotallingGLObj == null)
                    throw new ArgumentException ("Invalid Totalling Ledger", "TotallingGL");
                else
                {
                    if( TotallingGLObj.CompanyNo != CompanyNo || TotallingGLObj.Nature != NATURE ||
                        TotallingGLObj.CURR != CURR || TotallingGLObj.PostingLevel != POSTINGLEVEL) 
                            return string.Empty;
                }
            }
            #endregion

            #region Check_if_Exists
            int temp = 0;
            temp = temp.TryParse(LEDGERNO);
            if (ValidateExists(CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, UNITNO, POSTINGLEVEL, temp) == true)
                return string.Empty;
                
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
            // TODO
            //newGLTobeInserted.LedgerNO = LEDGERNO;
            newGLTobeInserted.STATUS = 1;
            newGLTobeInserted.COMMENTS = COMMENTS;
            // TODO
            //newGLTobeInserted.TotallingGL = TotallingGL;

            OpenCoreContext db = new OpenCoreContext();
            db.DEF_GL.Add(newGLTobeInserted);
            db.SaveChanges();
            #endregion

            return newGLTobeInserted.GL;
        }

        public static bool ValidateExists (short nCompany, byte nNature, string CurrISO, byte nZone, short nBranch, byte nSector,
                                          byte nDep, byte nUNITNO, byte nPOSTINGLEVEL , int Ledger)
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

        /*
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
        */


        // TODO :
        //public static string GetMaxLedger(int nCompany, byte nNature, string CurrISO, int nZone, int nBranch, int nSector,
        //                                  int nDep, int nUNITNO, short nProduct, int nPOSTINGLEVEL )
        //{
        //    OpenCoreContext db = new OpenCoreContext();

        //    //GL.CompanyNo = @CompanyNo AND GL.Zone = @Zone AND Gl.BranchNo = @BranchNo AND Gl.SectorNo = @SectorNo)

        //    // TODO : Done, Add more Conditions
        //    int stMaxLedger =    (from g in db.DEF_GL
        //                            where ( (nCompany > 0 && g.CompanyNo == nCompany) || 
        //                                    (nNature > 0 && g.Nature == nNature)  ||
        //                                    (nZone > 0 && g.Zone == nZone) ||
        //                                    (nBranch > 0 && g.BranchNo== nBranch) ||
        //                                    (nSector > 0 && g.SectorNo == nSector) ||
        //                                    (nDep > 0 && g.DepNo == nDep) ||
        //                                    (nUNITNO > 0 && g.UnitNO == nUNITNO) ||
        //                                    (nProduct > 0 && g.ProductNo == nProduct) ||
        //                                    (nPOSTINGLEVEL > 0 && g.PostingLevel == nPOSTINGLEVEL) )
        //                            select g.LedgerNO).Max();

        //    if(string.IsNullOrEmpty(stMaxLedger))
        //        stMaxLedger = Settings.fn_OPT_GetGLFormatDigits();

        //    return stMaxLedger;
        //}

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
            DEF_GL RetGL = GL.fn_String_ParseGL(stGL);
            
            //where		GLTbl.LedgerNO = @LedgerNO and GLTbl.Zone = @ZoneNo AND	
            //          GLTbl.CompanyNo = @CompanyNo and GLTbl.BranchNo = @BranchNo AND 
            //          GLTbl.CURR = @ISOCurr and GLTbl.SectorNo = @SectorNo and 
			//          GLTbl.DepNo = @DepNo and GLTbl.UnitNO = @UnitNO 
            return fn_GetGLInfo(RetGL, stCURR);
        }

        public static decimal GetLastBalance(string Acct_No, string Acct_Curr)
        {
            OpenCoreContext     db = new OpenCoreContext();
            decimal             ?BalanceAfter  ;

            BalanceAfter =  (from l in db.TRN_LEGS
                            where   l.GL == true && l.STATUS_ID == 1 && 
                                    l.Acct_No == Acct_No && l.Acct_Curr == Acct_Curr 
                            orderby l.EffDt descending , l.CREATE_DT descending, 
                                    l.TRN_LEGS_ID descending , l.Sequence descending
                             select l.Balance_After).FirstOrDefault();

            if (BalanceAfter.HasValue == false)
                return 0;

            return BalanceAfter.Value;
        }

        public static DEF_GL fn_String_ParseGL(string stGL)
        {
            if(string.IsNullOrEmpty(stGL))
                throw new ArgumentException("Invalid GL", "GL");

            // TODO : restrcture as Format should be dynamic


            DEF_GL RetGL = new DEF_GL();

            // SUBSTRING(@GL,1, 2)		'Zone',									-- Zone
            // SUBSTRING(@GL,4, 2)		'CompanyNo',							-- CompanyNo
            // SUBSTRING(@GL,7, 2)		'BranchNo',								-- BranchNo
            // SUBSTRING(@GL,10, 2)		'SectorNo',								-- SectorNo
            // SUBSTRING(@GL,13, 2)	'DepNo'	,								-- DepNo
            // SUBSTRING(@GL,16, 2)	'UnitNO',								-- UnitNO
            // SUBSTRING(@GL,19, dbo.fn_OPT_GetGLFormatDigitsNum()) 'LedgerNO'	-- LedgerNO
            //RetGL.Zone = (byte)int.Parse(stGL.Substring(0, 2));
            //RetGL.CompanyNo = (short)int.Parse(stGL.Substring(3, 2));
            //RetGL.BranchNo = (byte)int.Parse(stGL.Substring(6, 2));
            //RetGL.SectorNo = (byte)int.Parse(stGL.Substring(9, 2));
            //RetGL.DepNo = (byte)int.Parse(stGL.Substring(12, 2));
            //RetGL.UnitNO = (byte)int.Parse(stGL.Substring(15, 2));
            //RetGL.LedgerNO = stGL.Substring(18, Settings.fn_OPT_GetGLFormatDigitsNum());

            string SegmentsSetup = Settings.GetSystemSegments();
            string[] SegmentsSetupSplited = SegmentsSetup.Split('-');
            string[] GLSegments =   stGL.Split('-');

            // 
            if(SegmentsSetupSplited.Length != GLSegments.Length)
                throw new ArgumentException("Invalid GL", "GL");

            for(int nSeg=0; nSeg< GLSegments.Length; nSeg++)
            {
                // find the corresponding segment Setup
                Segment CurSegmentDef = (from s in _segments
                                        where s.Name == SegmentsSetupSplited[nSeg]
                                        select s).First();

                if(CurSegmentDef is null)
                    throw new ArgumentException("Invalid GL", "GL");

                if(GLSegments[nSeg].Length != CurSegmentDef.DigitsLength)
                    throw new ArgumentException("Invalid GL", "GL");

                UpdateGL(ref RetGL, CurSegmentDef, GLSegments[nSeg]);
            }

            return RetGL;
        }

        private static void UpdateGL(ref DEF_GL retGL, Segment curSegmentDef, string v)
        {
            switch (curSegmentDef.Type)
            {
                case 1: // Nature
                    retGL.Nature = retGL.Nature.TryParse(v) ;
                    break;
                case 2: // Zone
                    retGL.Zone = retGL.Zone.TryParse(v);
                    break;
                case 3: // CompanyNo
                    retGL.CompanyNo = retGL.CompanyNo.TryParse(v);
                    break;
                case 4: // BranchNo
                    retGL.BranchNo = retGL.BranchNo.TryParse(v);
                    break;
                case 5: // SectorNo
                    retGL.SectorNo = retGL.SectorNo.TryParse(v);
                    break;
                case 6: // DepNo
                    retGL.DepNo = retGL.DepNo.TryParse(v);
                    break;
                case 7: // UnitNo
                    retGL.UnitNO = retGL.UnitNO.TryParse(v);
                    break;
                case 8: // ProductNo
                    retGL.ProductNo = retGL.ProductNo.TryParse(v);
                    break;
                case 9: // PostingLevel
                    retGL.PostingLevel = retGL.PostingLevel.TryParse(v);
                    break;
                case 10: // LedgerNo
                    retGL.LedgerNO = retGL.LedgerNO.TryParse(v);
                    break;
            }
        }
    }
}