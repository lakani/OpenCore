select * from OpenCore..TRN_LEGS 
select * from OpenCore..LUT_TRN_STATUS

update OpenCore..TRN_LEGS  
set STATUS_ID = 1
where Ref = 'F4B777D5-9033-42A2-BB65-147D3C1701A0'

delete OpenCore..TRN_LEGS  where Ref = '86A3336D-0230-4F13-B355-7F7EA48F8D17'

select * from TRN_LEGS where Acct_No like '01-01-01-01-01-01-00010'


	USE [OpenCore]
	GO
--REFRENCE TYPE

	DECLARE @RC int
	DECLARE @Ref uniqueidentifier
	DECLARE	@LegsParam TYPE_POST_TRAN_PARAM;
	DECLARE @SumOfCR TINYINT;
	DECLARE @SumOfDR TINYINT;

--	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00010', 1, 250, 'EGP', '20190101', 'Desc')
--	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00001', 1, 250, 'EGP', '20190101', 'Desc')
--	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00004', 1, 250, 'EGP', '20190101', 'Desc')
--	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00010', 1, 250, 'EGP', '20190101', 'Desc')

--	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00011', 1, 1000, 'EGP', '20190101', 'Expenses 1')
--	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00010', 1, 1000, 'EGP', '20190101', 'Expenses 1')

--	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00004', 1, 1000000, 'EGP', '20190101', 'Capital Increase')
--	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00010', 1, 1000000, 'EGP', '20190101', 'Capital Increase')

--	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00006', 1, 1000000, 'EGP', '20190101', 'Loan Recieved')
--	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00010', 1, 1000000, 'EGP', '20190101', 'Loan Recieved')

--	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00008', 1, 529650, 'EGP', '20190101', 'Profit Accrual')
--	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00010', 1, 529650, 'EGP', '20190101', 'Profit Accrual')
--	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00011', 1, 529650, 'EGP', '20190101', 'Profit Accrual')
--	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00002', 1, 529650, 'EGP', '20190101', 'Profit Accrual')

	insert into @LegsParam Values( 'CR', '01-01-01-01-01-01-00010', 1, 150000, 'EGP', '20190101', 'Cash Deposit')
	insert into @LegsParam Values( 'DR', '01-01-01-01-01-01-00002', 1, 150000, 'EGP', '20190101', 'Cash Deposit')

	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-00001' ,1 ,18252 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Dr' ,'01-01-01-01-01-01-00010' ,1 ,18252 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-10430' ,1 ,78945 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Dr' ,'01-01-01-01-01-01-10440' ,1 ,78945 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-10430' ,1 ,100 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Dr' ,'01-01-01-01-01-01-10430' ,1 ,100 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-10430' ,1 ,10000 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Dr' ,'01-01-01-01-01-01-10440' ,1 ,10000 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-64000' ,1 ,400 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-00001' ,1 ,799600 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Dr' ,'01-01-01-01-01-01-10488' ,1 ,800000 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-10430' ,1 ,1000 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Dr' ,'01-01-01-01-01-01-30030' ,1 ,1000 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-00001' ,1 ,1800 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Cr' ,'01-01-01-01-01-01-64030' ,1 ,200 ,'EGP' ,'20190101' ,'Manual AE' )
	insert into @LegsParam Values( 'Dr' ,'01-01-01-01-01-01-10477' ,1 ,2000 ,'EGP' ,'20190101' ,'Manual AE' )

	
--	select top 1 ls.Acct_No from @LegsParam ls where ls.GL = 1

	-- TODO: Set parameter values here.
	EXECUTE @RC = [dbo].[SP_POST_TRAN] @Ref OUTPUT ,@LegsParam
	GO

--	select @RC 'RC'

	--select * from TRN_LEGS where Acct_Description like '%Profit%' order by CREATE_DT desc
	--delete TRN_LEGS
	select GL, CompanyName, ZoneName, BranchName, SectorName, NatureName, CR_DR, CURR, dbo.fn_ACT_GL_GetLastBalance(GL, CURR) 'Balance', TotallingGL
	from VW_DEF_GL Order by Balance desc


	--select * from TRN_LEGS
	--DELETE TRN_LEGS

