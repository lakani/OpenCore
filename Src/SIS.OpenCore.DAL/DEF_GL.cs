using System;
using System.Linq;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.DAL.Context;

using System.Collections.Generic;

namespace SIS.OpenCore.DAL // Check the correct table attributes
{
    public partial class DEF_GL_DAL
    {
        // static public string AddGL(DateTime EFFECTIVE_DT, short CompanyNo, short NATURE, 
        //     short nZone, short BranchNo, short SectorNo, short DepNo, short UNITNO, short ProductNo, int LEDGERNO, string GL,string COMMENTS)
        // {
        //     DEF_GL newGLTobeInserted = new DEF_GL();
        //     newGLTobeInserted.EFFECTIVE_DT = EFFECTIVE_DT;
        //     newGLTobeInserted.CompanyNo = CompanyNo;
        //     newGLTobeInserted.Nature = NATURE;
        //     newGLTobeInserted.Zone = nZone;
        //     newGLTobeInserted.BranchNo = BranchNo;
        //     newGLTobeInserted.SectorNo = SectorNo;
        //     newGLTobeInserted.DepNo = DepNo;
        //     newGLTobeInserted.UnitNO = UNITNO;
        //     newGLTobeInserted.ProductNo = ProductNo;
        //     newGLTobeInserted.LedgerNO = LEDGERNO;
        //     newGLTobeInserted.GL = GL;
        //     newGLTobeInserted.COMMENTS = COMMENTS;
        //     newGLTobeInserted.STATUS = 1;
            
        //     return AddGl(newGLTobeInserted);
        // }

        // public static bool ValidateExists(string stGL)
        // {
        //     OpenCoreContext db = new OpenCoreContext();

        //     int cRecords = (from g in db.DEF_GL
        //                     where g.GL == stGL
        //                     select g.LedgerNO).Count();

        //     if (cRecords > 0)
        //         return true;
        //     else
        //         return false;
        // }

        // private static string AddGl(DEF_GL newRecord)
        // {
            
        //     OpenCoreContext db = new OpenCoreContext();
        //     db.DEF_GL.Add(newRecord);
        //     db.SaveChanges();

        //     return newRecord.GL;
        // }

        public static DEF_GL[] List(short cRecordsPerPage)
        {
            OpenCoreContext db = new OpenCoreContext();

            return ((from g in db.DEF_GL
                    where g.STATUS == 1
                    orderby g.GL_DEFID descending
                    select g).Take(cRecordsPerPage).ToArray());
        }

        
    }
}
