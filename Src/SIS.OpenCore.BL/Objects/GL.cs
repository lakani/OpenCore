using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Model;
using System.Linq;
using DAL = SIS.OpenCore.DAL;
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
                int         LEDGERNO = 0,
                string      GL = "",
                string      COMMENTS = "",
                string      REFERENCE	=""
         )
        {
            if(false == ValidatesNewGLParams(ref EFFECTIVE_DT, CompanyNo, nZone, BranchNo, SectorNo, DepNo, UNITNO, ref CURR))
                throw new ArgumentException("ValidatesNewGLParams", "ValidatesNewGLParams");

            if (LEDGERNO == 0)
            {
                LEDGERNO = DAL.DEF_GL_DAL.GetMaxLedger(CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, POSTINGLEVEL);
                LEDGERNO++;
            }
                                
            if (string.IsNullOrEmpty(GL) == true)
            {
                // GenerateGL
                GL = GenerateGL(CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, POSTINGLEVEL, LEDGERNO);
                GL = GL.TrimEnd();
            }

            if (ValidateExists(CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, POSTINGLEVEL, LEDGERNO, GL) == true)
                throw new ArgumentException("GL", "GL Already Exists");

            return DAL.DEF_GL_DAL.AddGL(EFFECTIVE_DT, CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, POSTINGLEVEL,
                                    LEDGERNO, GL, COMMENTS);
        }


        static public string Create(DEF_GL newGL)
        {
            return  Add_GL(newGL.EFFECTIVE_DT, newGL.CompanyNo, newGL.Nature, 
                newGL.Zone.HasValue? newGL.Zone.Value:0, 
                newGL.BranchNo.HasValue ? newGL.BranchNo.Value :0,
                newGL.SectorNo.HasValue ? newGL.SectorNo.Value : 0 ,
                newGL.DepNo.HasValue ? newGL.DepNo.Value : 0, 
                newGL.UnitNO.HasValue ? newGL.UnitNO.Value : 0, 
                newGL.ProductNo.HasValue ? newGL.ProductNo.Value : 0, 
                newGL.CURR, 
                newGL.PostingLevel, 
                newGL.LedgerNO,  newGL.GL, newGL.COMMENTS, newGL.REFERENCE);
         
        }

        public static DEF_GL[] List(short cRecordsPerPage)
        {
            return DAL.DEF_GL_DAL.List(cRecordsPerPage);
        }



        private static bool ValidatesNewGLParams( ref DateTime EFFECTIVE_DT, short CompanyNo, byte nZone, short BranchNo, byte SectorNo, byte DepNo, 
                                            byte UNITNO, ref string CURR)
        {
            //-- if not supplied , assume its the base currency
            if (String.IsNullOrEmpty(CURR))
                CURR = Settings.fn_OPT_GetBaseCurrency();
            if (string.IsNullOrEmpty(CURR))
                throw new Exception("fn_OPT_GetBaseCurrency can’t retrieve base currency");

            //-- if not supplied , assume its current bussiness date
            if (EFFECTIVE_DT <= DateTime.MinValue || EFFECTIVE_DT >= DateTime.MaxValue)
                EFFECTIVE_DT = Settings.GetCurrentBusinessDate();

            //-- check paramters
            //PRINT 'Checking DEF_Currency Table'
            if (!Currency.ValidateExists(CURR))
                throw new ArgumentOutOfRangeException("CURR", "Currency doesn't Exists");
            //PRINT 'Checking Company in DEF_Company Table'
            if (!Company.ValidateExists(CompanyNo))
                throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");
            //PRINT 'Checking DEF_Zone Table'
            if (nZone != 0)
                if (!Zone.ValidateExists((byte)nZone))
                    throw new ArgumentOutOfRangeException("nZone", "Zone Number doesn't Exists");
            //PRINT 'Checking DEF_Branch Table'
            if (BranchNo != 0)
                if (!Branch.ValidateExists((short)BranchNo))
                    throw new ArgumentOutOfRangeException("BranchNo", "Branch Number doesn't Exists");
            //PRINT 'Checking DEF_Sector Table'
            if (SectorNo != 0)
                if (!Sector.ValidateExists((byte)SectorNo))
                    throw new ArgumentOutOfRangeException("SectorNo", "Sector Number doesn't Exists");
            //PRINT 'Checking DEF_Dep Table'
            if (DepNo != 0)
                if (!Dep.ValidateExists((byte)DepNo))
                    throw new ArgumentOutOfRangeException("DepNo", "Department Number doesn't Exists");
            //PRINT 'Checking DEF_Unit Table'
            if (UNITNO != 0)
                if (!Unit.ValidateExists((byte)UNITNO))
                    throw new ArgumentOutOfRangeException("UNITNO", "Unit Number doesn't Exists");

            return true;
        }

        public static bool ValidateExists (short nCompany, byte nNature, string CurrISO, byte nZone, short nBranch, byte nSector,
                                          byte nDep, byte nUNITNO, short ProductNo, byte nPOSTINGLEVEL , int Ledger, String stGL)
        {
            // need to have two checks 
            //  1- check only for the GL string
            //  2- check for all the below paramaters 

            if (DAL.DEF_GL_DAL.ValidateExists(stGL) == true)
                return true;          


            DEF_GL  gl = new DEF_GL() {
                CompanyNo = nCompany,
                Nature = nNature,
                CURR = CurrISO, 
                Zone = nZone,
                BranchNo = nBranch,
                SectorNo = nSector,
                DepNo = nDep,
                UnitNO = nUNITNO,
                ProductNo = ProductNo,
                PostingLevel = nPOSTINGLEVEL,
                LedgerNO = Ledger,
                GL = stGL
            };

            gl = GetGLInfo(gl, stGL, gl.CURR);
            if(gl != null)
                return true;

            return false;
        }

        public static DEF_GL GetGLInfo(DEF_GL gL, string stGL, string stCURR)
        {
            OpenCoreContext db = new OpenCoreContext();
            var RetGL = (from g in db.DEF_GL
                        where   g.CompanyNo == gL.CompanyNo &&
                                g.Nature == gL.Nature &&
                                g.CURR == stCURR &&
                                g.Zone == gL.Zone &&
                                g.BranchNo == gL.BranchNo &&
                                g.SectorNo == gL.SectorNo &&
                                g.DepNo == gL.DepNo &&
                                g.UnitNO == gL.UnitNO &&
                                g.ProductNo == gL.ProductNo &&
                                g.PostingLevel == gL.PostingLevel &&
                                g.LedgerNO == gL.LedgerNO &&
                                g.GL == stGL 
                         select g).FirstOrDefault();
                        
            return RetGL;
        }
        public static DEF_GL GetGLInfo(string stGL, string stCURR)
        {
            DEF_GL RetGL = GL.fn_String_ParseGL(stGL);
            
            return GetGLInfo(RetGL, stGL, stCURR);
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

            // TRIM Right
            stGL = stGL.TrimEnd();

            DEF_GL RetGL = new DEF_GL();
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
                    throw new ArgumentException("CurSegmentDef", "Segments Setup is Wrong");

                if(GLSegments[nSeg].Length != CurSegmentDef.DigitsLength)
                    throw new ArgumentException("Invalid GL", "GL");

                UpdateGL(ref RetGL, CurSegmentDef, GLSegments[nSeg]);
            }
            return RetGL;
        }

        public static void GenerateGLString(ref string RetGL, Segment Segment, short CompanyNo, byte NATURE, string CURR, byte nZone, 
                                        short BranchNo, byte SectorNo,
                                        byte DepNo, byte UNITNO, short ProductNo, byte POSTINGLEVEL, int LEDGERNO, bool isLastSeg)
        {
            switch (Segment.Type)
            {
                case 1: // Nature
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", NATURE);
                    break;
                case 2: // Zone
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", nZone);
                    break;
                case 3: // CompanyNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", CompanyNo);
                    break;
                case 4: // BranchNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", BranchNo);
                    break;
                case 5: // SectorNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", SectorNo);
                    break;
                case 6: // DepNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", DepNo);
                    break;
                case 7: // UnitNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", UNITNO);
                    break;
                case 8: // ProductNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", ProductNo);
                    break;
                case 9: // PostingLevel
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", POSTINGLEVEL);
                    break;
                case 10: // LedgerNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", LEDGERNO);
                    break;
            }

            if (isLastSeg == false)
                RetGL += "-";
        }

        public static string GenerateGL(short CompanyNo,    byte NATURE, string CURR , byte nZone , short BranchNo , byte SectorNo ,
                                        byte DepNo , byte UNITNO , short ProductNo , byte POSTINGLEVEL , int LEDGERNO )
        {
            string SegmentsSetup = Settings.GetSystemSegments();
            string[] SegmentsSetupSplited = SegmentsSetup.Split('-');
            string RetGL = String.Empty;

            for (int nSeg = 0; nSeg < SegmentsSetupSplited.Length; nSeg++)
            {
                Segment CurSegmentDef = (from s in _segments
                                         where s.Name == SegmentsSetupSplited[nSeg]
                                         select s).First();

                if (CurSegmentDef is null)
                    throw new ArgumentException("CurSegmentDef", "Segments Setup is Wrong");

                bool LastSegment = (nSeg == (SegmentsSetupSplited.Length - 1)) ? true: false;
                GenerateGLString(ref RetGL, CurSegmentDef, CompanyNo, NATURE, CURR, nZone, BranchNo, SectorNo, DepNo, 
                        UNITNO, ProductNo, POSTINGLEVEL, LEDGERNO, LastSegment);

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