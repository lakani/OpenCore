USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[RANDBETWEEN]    Script Date: 17/12/2019 13:45:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER FUNCTION [dbo].[RANDBETWEEN](@minval TINYINT, @maxval TINYINT, @random NUMERIC(18,10))
RETURNS TINYINT
AS
BEGIN
  RETURN (SELECT CAST(((@maxval + 1) - @minval) * @random + @minval AS TINYINT))
END
GO

