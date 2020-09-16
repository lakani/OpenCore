USE [OpenCore]
GO

-- 64037
select * from DEF_GL where LedgerNO like '%99999%'

DECLARE @RC int
DECLARE @LEDGERNO_OUT nvarchar(15)
DECLARE @CompanyNo int
DECLARE @Zone int
DECLARE @BranchNo int
DECLARE @SectorNo int
DECLARE @DepNo int
DECLARE @UNITNO int
DECLARE @NATURE int
DECLARE @LEDGERNO nvarchar(max)
DECLARE @TotallingGL nvarchar(100)
DECLARE @POSTINGLEVEL int
DECLARE @CURR nvarchar(4)
DECLARE @COMMENTS nvarchar(200)
DECLARE @EFFECTIVE_DT datetime
DECLARE @REFERENCE nvarchar(max)

-- TODO: Set parameter values here.
set @CompanyNo = 1;
set @Zone = 1;
set @BranchNo = 1;
set @SectorNo = 1;
set @DepNo = 1;
set @UNITNO = 1;
set @NATURE = 5;  -- 1	Asset , 2	Liability , 3	Income , 4	Expense , 5	Capital
--set @LEDGERNO = '10477'; --01-01-01-01-01-01-30030
set @POSTINGLEVEL = 1;
set @CURR  = 'EGP';
SET @TotallingGL  = '01-01-01-01-01-01-00010';

EXECUTE @RC = [dbo].[SP_AddGL]      @LEDGERNO_OUT OUTPUT           ,
                    @CompanyNo  ,@Zone  ,@BranchNo ,@SectorNo ,@DepNo ,@UNITNO ,@NATURE ,@LEDGERNO ,@TotallingGL ,@POSTINGLEVEL,
                    @CURR ,@COMMENTS ,@EFFECTIVE_DT ,@REFERENCE
GO

select GL, LEN(GL), CompanyName, ZoneName, BranchName, SectorName, NatureName, CR_DR, CURR, dbo.fn_ACT_GL_GetLastBalance(GL, CURR) 'Balance' , TotallingGL
	from VW_DEF_GL Order by Balance desc , NatureName asc
