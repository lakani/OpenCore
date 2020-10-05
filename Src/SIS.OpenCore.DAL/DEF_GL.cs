using System;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL.Context;
using System.Collections.Generic;

namespace SIS.OpenCore.DAL // Check the correct table attributes
{
    public partial class DEF_GL_DAL
    {
        static public string AddGL(DateTime EFFECTIVE_DT, short CompanyNo, byte NATURE, string CURR,
            byte nZone, short BranchNo, byte SectorNo, byte DepNo, byte UNITNO, byte POSTINGLEVEL, 
            string COMMENTS)
        {
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

            return newGLTobeInserted.GL;
        }
    }
}
