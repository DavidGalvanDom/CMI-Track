USE [CMITrack]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_getCodigoSerie]    Script Date: 10/06/2016 07:47:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufn_getCodigoSerie] ( @id INT )
RETURNS NVARCHAR(2)
AS
BEGIN
-- REVISION
/*

DECLARE @pos int
SET @pos = 1;
WHILE @pos <= 2000
   BEGIN
   PRINT CONCAT(@pos,' -> ',[dbo].[ufn_getCodigoSerie] (@pos));
   SET @pos = @pos + 1;
   END;
GO

*/

-- Declaracion de Variables
DECLARE @codigoSerie NCHAR(2) = ''
DECLARE @var INT
DECLARE @centena INT
DECLARE @veintiseicena INT
DECLARE @treintayseicena INT
DECLARE @treintaiseicena INT
DECLARE @numerosnaturales INT

---------------

IF @id < 1296
BEGIN
	SET @centena = FLOOR(@id / 100)

	-- Si el id se encuentra entre 0 y 99
	IF @centena = 0 
	BEGIN
		SET @codigoSerie = RIGHT('0' + CAST(@id AS NVARCHAR(2)), 2)
	END
	ELSE 
	BEGIN
		SET @treintayseicena = FLOOR(@id / 360)
		
		-- Si el id se encuentra entre 100 y 360
		IF @treintayseicena = 0
		BEGIN
			SET @veintiseicena = FLOOR((@id - 100) / 26);
			SET @codigoSerie = CONCAT(@veintiseicena, CHAR((@id - 100) - (26 * @veintiseicena) + 65));
		END
		ELSE
		BEGIN
			-- Si el id se encuentra entre 361 y 1035
			SET @treintaiseicena = FLOOR((@id - 360) / 36);
			
			IF ((cast( ((@id-360) / 36.0) as float) - @treintaiseicena) * 100) <= 27.77
			BEGIN
			  SET @numerosnaturales = 17;
			END
			ELSE
			BEGIN
			  SET @numerosnaturales = 10;
			END
			
			SET @codigoSerie = CONCAT(CHAR(@treintaiseicena + 65),CHAR((@id - 360) - (36 * @treintaiseicena) + 65 - @numerosnaturales));
		END
	END
END
ELSE BEGIN
	SET @codigoSerie ='-1'
END

RETURN @codigoSerie
END


GO
