using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.GL;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System.Linq;
using DAL = SIS.OpenCore.Server.Data;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.BL;
using SIS.OpenCore.Shared.Extensions;
using SIS.OpenCore.Server.Data.Repository.Interface;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;

//using SIS.OpenCore.Server.Data.Repository.Interface;


namespace SIS.OpenCore.Server.BL.Objects
{
    public static partial class GL
    {
        //protected static IUserDataRepository<Zone> _Zone;

        private static  ILogger _logger;
		private static  IConfiguration _configuration;
		private static  SignInManager<ApplicationUser> _signInManager;
		private static  IUserDataRepository<Zone> _ZoneRepository;
		private static  IUserDataRepository<DEF_Company> _CompanyRepository;
		private static  IUserDataRepository<DEF_Branch> _BranchRepository;
		private static  IUserDataRepository<DEF_Sector> _SectorRepository;
		private static  IUserDataRepository<DEF_Dep> _DepRepository;
		private static  IUserDataRepository<DEF_Unit> _UnitRepository;
        private static  ISettingsRepository<SettingsModel> _SettingsRepository;
        private static  IDEF_GLRepository<DEF_GL> _DEF_GLRepository;
        private static  ILUTRepository<LUT_GLLedgerNature> _lut_GLLedgerNatureRepository;

        public static void InitServices(ILogger logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<Zone> ZoneRepository,
		IUserDataRepository<DEF_Company> CompanyRepository,
		IUserDataRepository<DEF_Branch> BranchRepository,
		IUserDataRepository<DEF_Sector> SectorRepository,
		IUserDataRepository<DEF_Dep> DepRepository,
		IUserDataRepository<DEF_Unit> UnitRepository,
        ISettingsRepository<SettingsModel> settingsRepository,
        IDEF_GLRepository<DEF_GL> DEF_GLRep, 
        ILUTRepository<LUT_GLLedgerNature> LUT_GLLedgerNatureRepository) 
		{
			_logger = logger;
			_configuration = Configuration;
			_signInManager = signInManager;
			_ZoneRepository = ZoneRepository;
			_CompanyRepository = CompanyRepository;
			_BranchRepository = BranchRepository;
			_SectorRepository = SectorRepository;
			_DepRepository = DepRepository;
			_UnitRepository = UnitRepository;
            _SettingsRepository = settingsRepository;
            _DEF_GLRepository = DEF_GLRep; 
            _lut_GLLedgerNatureRepository = LUT_GLLedgerNatureRepository;

			_logger.Log(LogLevel.Information, "GL : InitServices");
		}

        // TODO : should match the number of diggits from the Setup , not from the below table
        // for example if specified in the setup that BranchNo is only 2 diggits, it should be generated as 2
		static GLSegment[] _segments = new GLSegment[] {   
            new GLSegment { Type = 1,   Name = "Nature",          DigitsValue = "#",      DigitsLength = 1},
            new GLSegment { Type = 2,   Name = "Zone",            DigitsValue = "##",     DigitsLength = 2},
            new GLSegment { Type = 3,   Name = "CompanyNo",       DigitsValue = "##",     DigitsLength = 2},
            new GLSegment { Type = 4,   Name = "BranchNo",        DigitsValue = "####",   DigitsLength = 4},
            new GLSegment { Type = 5,   Name = "SectorNo",        DigitsValue = "##",     DigitsLength = 2},
            new GLSegment { Type = 6,   Name = "DepNo",           DigitsValue = "##",     DigitsLength = 2},
            new GLSegment { Type = 7,   Name = "UnitNo",          DigitsValue = "##",     DigitsLength = 2},
            new GLSegment { Type = 8,   Name = "ProductNo",       DigitsValue = "####",   DigitsLength = 4},
            new GLSegment { Type = 9,  Name = "LedgerNo",        DigitsValue = "######", DigitsLength = 6}};

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
        // @CURR			nvarchar(4) = null, 
        // @COMMENTS		nvarchar(200) = null,
        // @EFFECTIVE_DT	datetime = null,
        // @REFERENCE		nvarchar(MAX) = null
        // static public async Task<string> Add_GL (
        //         DateTime    EFFECTIVE_DT ,
        //         short       CompanyNo,
        //         short        NATURE,
        //         short        nZone = 0,
        //         short       BranchNo = 0,
        //         short        SectorNo = 0,
        //         short        DepNo = 0,
        //         short        UNITNO = 0,
        //         short       ProductNo = 0,
        //         int         LEDGERNO = 0,
        //         string      GL = "",
        //         string      COMMENTS = "",
        //         string      REFERENCE	=""
        //  )
        // {
        //     //-- if not supplied , assume its current bussiness date
        //     if (EFFECTIVE_DT <= DateTime.MinValue || EFFECTIVE_DT >= DateTime.MaxValue)
        //         EFFECTIVE_DT = Settings.GetCurrentBusinessDate();

        //     if(false == ValidatesNewGLParams(EFFECTIVE_DT, CompanyNo, nZone, BranchNo, SectorNo, DepNo, UNITNO))
        //         throw new ArgumentException("ValidatesNewGLParams", "ValidatesNewGLParams");

        //     if (LEDGERNO == 0)
        //     {
        //         LEDGERNO = DAL.DEF_GL_DAL.GetMaxLedger(CompanyNo, NATURE, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo);
        //         LEDGERNO++;
        //     }
                                
        //     if (string.IsNullOrEmpty(GL) == true)
        //     {
        //         // GenerateGL
        //         GL = GenerateGL(CompanyNo, NATURE, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, LEDGERNO);
        //         GL = GL.TrimEnd();
        //     }

        //     if (ValidateExists(CompanyNo, NATURE, nZone, BranchNo, SectorNo, DepNo, UNITNO, ProductNo, LEDGERNO, GL) == true)
        //         throw new ArgumentException("GL", "GL Already Exists");

        //     await _DEF_GLRepository.Create(new DEF_GL{
        //         EFFECTIVE_DT = EFFECTIVE_DT,
        //         CompanyNo = CompanyNo, Nature = NATURE, Zone = nZone, BranchNo = BranchNo, SectorNo = SectorNo, 
        //         DepNo = DepNo, UnitNO = UNITNO, ProductNo = ProductNo, LedgerNO = LEDGERNO,
        //         GL = GL, COMMENTS = COMMENTS});

        //     return GL;
        // }

        static public async Task<string> Create(DEF_GL newGL)
        {
            //-- if not supplied , assume its current bussiness date
            if (newGL.EFFECTIVE_DT  <= DateTime.MinValue || newGL.EFFECTIVE_DT >= DateTime.MaxValue)
                newGL.EFFECTIVE_DT = Settings.GetCurrentBusinessDate();

            if(false == ValidatesNewGLParams(newGL.EFFECTIVE_DT, newGL.CompanyNo, newGL.Zone ?? 0, newGL.BranchNo ?? 0, 
            newGL.SectorNo ?? 0, newGL.DepNo ?? 0, newGL.UnitNO ?? 0, newGL.Nature))
                throw new ArgumentException("ValidatesNewGLParams", "ValidatesNewGLParams");

            if (newGL.LedgerNO == 0)
            {
                newGL.LedgerNO = _DEF_GLRepository.GetMaxLedger(newGL.CompanyNo, newGL.Nature, newGL.Zone, newGL.BranchNo, 
                newGL.SectorNo, newGL.DepNo, newGL.UnitNO, newGL.ProductNo);
                newGL.LedgerNO++;
            }
                                
            if (string.IsNullOrEmpty(newGL.GL) == true)
            {
                // GenerateGL
                newGL.GL = GenerateGL(newGL.CompanyNo, newGL.Nature, newGL.Zone ?? 0, newGL.BranchNo ?? 0, newGL.SectorNo ?? 0, 
                newGL.DepNo, newGL.UnitNO, newGL.ProductNo, newGL.LedgerNO);
                newGL.GL = newGL.GL.TrimEnd();
            }

            if (ValidateExists(newGL.CompanyNo, newGL.Nature, newGL.Zone, newGL.BranchNo, newGL.SectorNo, newGL.DepNo,
             newGL.UnitNO, newGL.ProductNo, newGL.LedgerNO, newGL.GL) == true)
                throw new ArgumentException("GL", "GL Already Exists");

            await _DEF_GLRepository.Create(newGL);

            return newGL.GL;

            // return  await Add_GL(newGL.EFFECTIVE_DT, newGL.CompanyNo, newGL.Nature, 
            //     newGL.Zone.Value, 
            //     newGL.BranchNo.Value ,
            //     newGL.SectorNo.Value ,
            //     newGL.DepNo.Value , 
            //     newGL.UnitNO.Value , 
            //     newGL.ProductNo.Value , 
            //     newGL.LedgerNO,  newGL.GL, newGL.COMMENTS, newGL.REFERENCE);
         
        }

        private static bool ValidatesNewGLParams(DateTime EFFECTIVE_DT, short CompanyNo, short nZone, short BranchNo, 
                                    short SectorNo, short DepNo, short UNITNO, short Nature)
        {
            //-- if not supplied , assume its the base currency
            // if (String.IsNullOrEmpty(CURR))
            //     CURR = Settings.fn_OPT_GetBaseCurrency();
            // if (string.IsNullOrEmpty(CURR))
            //     throw new Exception("fn_OPT_GetBaseCurrency can’t retrieve base currency");

            

            //-- check paramters
            //PRINT 'Checking DEF_Currency Table'
            // if (!Currency.ValidateExists(CURR))
            //     throw new ArgumentOutOfRangeException("CURR", "Currency doesn't Exists");
            //PRINT 'Checking Company in DEF_Company Table'
            if(_CompanyRepository.GetById(CompanyNo) == null)
                    throw new ArgumentOutOfRangeException("CompanyNo", "Company Number doesn't Exists");
            
            if(_lut_GLLedgerNatureRepository.GetById(Nature) == null)
                throw new ArgumentOutOfRangeException("Nature", "Invalid GL Nature");
            
             //PRINT 'Checking Zone Table'
            if (nZone != 0)
                if(_ZoneRepository.GetById(nZone) == null)
                    throw new ArgumentOutOfRangeException("nZone", "Zone Number doesn't Exists");
                            
            //PRINT 'Checking DEF_Branch Table'
            if (BranchNo != 0)
            {
                if (_BranchRepository.GetById(BranchNo) == null)
                    throw new ArgumentOutOfRangeException("BranchNo", "Branch Number doesn't Exists");

            }
        
            //PRINT 'Checking DEF_Sector Table'
            if (SectorNo != 0 )
                if(_SectorRepository.GetById(SectorNo) == null)
                    throw new ArgumentOutOfRangeException("SectorNo", "Sector Number doesn't Exists");
            
            //PRINT 'Checking DEF_Dep Table'
            if (DepNo != 0 )
                if(_DepRepository.GetById(DepNo) == null)
                    throw new ArgumentOutOfRangeException("DepNo", "Department Number doesn't Exists");    
                       
                
            //PRINT 'Checking DEF_Unit Table'
            if (UNITNO != 0 )
                if(_UnitRepository.GetById(UNITNO) == null)   
                    throw new ArgumentOutOfRangeException("UNITNO", "Unit Number doesn't Exists");    
                       
            return true;
        }

        public static bool ValidateExists (short nCompany, short nNature, short? nZone, short? nBranch, short? nSector,
                                          short? nDep, short? nUNITNO, short? ProductNo, int Ledger, String stGL)
        {
            // need to have two checks 
            //  1- check only for the GL string
            //  2- check for all the below paramaters 

            if(_DEF_GLRepository.GetByCode(stGL) != null)
                return true;

            // TODO search for matching for the paramaters, 


            // // if (DAL.DEF_GL_DAL.ValidateExists(stGL) == true)
            // //     return true;          


            // DEF_GL  gl = new DEF_GL() {
            //     CompanyNo = nCompany,
            //     Nature = nNature,
            //     Zone = nZone,
            //     BranchNo = nBranch,
            //     SectorNo = nSector,
            //     DepNo = nDep,
            //     UnitNO = nUNITNO,
            //     ProductNo = ProductNo,
            //     LedgerNO = Ledger,
            //     GL = stGL
            // };

            // _DEF_GLRepository.Create(gl);

            // gl = GetGLInfo(gl, stGL);
            // if(gl != null)
            //     return true;

            return false;
        }

        // public static DEF_GL GetGLInfo(DEF_GL gL, string stGL)
        // {
        //     // TODO : remove any mention for OpenCoreContext 
        //     OpenCoreContext db = new OpenCoreContext();
        //     var RetGL = (from g in db.DEF_GL
        //                 where   g.CompanyNo == gL.CompanyNo &&
        //                         g.Nature == gL.Nature &&
        //                         g.Zone == gL.Zone &&
        //                         g.BranchNo == gL.BranchNo &&
        //                         g.SectorNo == gL.SectorNo &&
        //                         g.DepNo == gL.DepNo &&
        //                         g.UnitNO == gL.UnitNO &&
        //                         g.ProductNo == gL.ProductNo &&
        //                         g.LedgerNO == gL.LedgerNO &&
        //                         g.GL == stGL 
        //                  select g).FirstOrDefault();
                        
        //     return RetGL;
        // }
        // public static DEF_GL GetGLInfo(string stGL, string stCURR)
        // {
        //     DEF_GL RetGL = GL.fn_String_ParseGL(stGL);
            
        //     return GetGLInfo(RetGL, stGL);
        // }

        public static decimal GetLastBalance(string Acct_No, string Acct_Curr)
        {
            //DeadCode
            // OpenCoreContext     db = new OpenCoreContext();
            // decimal             ?BalanceAfter  ;

            // BalanceAfter =  (from l in db.TRN_LEGS
            //                 where   l.GL == true && l.STATUS_ID == 1 && 
            //                         l.Acct_No == Acct_No && l.Acct_Curr == Acct_Curr 
            //                 orderby l.EffDt descending , l.CREATE_DT descending, 
            //                         l.TRN_LEGS_ID descending , l.Sequence descending
            //                  select l.Balance_After).FirstOrDefault();

            // if (BalanceAfter.HasValue == false)
            //     return 0;

            // return BalanceAfter.Value;
            return 0;
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
                GLSegment CurSegmentDef = (from s in _segments
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

        public static void GenerateGLString(ref string RetGL, GLSegment Segment, short CompanyNo, short NATURE, short nZone, 
                                        short BranchNo, short SectorNo,
                                        short DepNo, short UNITNO, short ProductNo, int LEDGERNO, bool isLastSeg)
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
                case 9: // LedgerNo
                    RetGL += String.Format("{0:" + Segment.DigitsValue.Replace('#', '0') + "}", LEDGERNO);
                    break;
            }

            if (isLastSeg == false)
                RetGL += "-";
        }

        public static string GenerateGL(short CompanyNo,    short NATURE, short nZone , short BranchNo , short SectorNo ,
                                        short? DepNo , short? UNITNO , short? ProductNo , int LEDGERNO )
        {
            //
            Settings.InitServices(_logger, _configuration, _SettingsRepository);

            string SegmentsSetup = Settings.GetSystemSegments();
            string[] SegmentsSetupSplited = SegmentsSetup.Split('-');
            string RetGL = String.Empty;

            for (int nSeg = 0; nSeg < SegmentsSetupSplited.Length; nSeg++)
            {
                GLSegment CurSegmentDef = (from s in _segments
                                         where s.Name == SegmentsSetupSplited[nSeg]
                                         select s).First();

                if (CurSegmentDef is null)
                    throw new ArgumentException("CurSegmentDef", "Segments Setup is Wrong");

                bool LastSegment = (nSeg == (SegmentsSetupSplited.Length - 1)) ? true: false;
                GenerateGLString(ref RetGL, CurSegmentDef, CompanyNo, NATURE, nZone, BranchNo, SectorNo, DepNo ?? 0, 
                        UNITNO ?? 0, ProductNo ?? 0, LEDGERNO, LastSegment);

            }
            return RetGL;
        }

        private static void UpdateGL(ref DEF_GL retGL, GLSegment curSegmentDef, string v)
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
                case 9: // LedgerNo
                    retGL.LedgerNO = retGL.LedgerNO.TryParse(v);
                    break;
            }
        }
    }
}