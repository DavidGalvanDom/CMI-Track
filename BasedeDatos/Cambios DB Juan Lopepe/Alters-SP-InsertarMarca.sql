USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMarca]    Script Date: 02/06/2016 11:20:37 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[usp_InsertarMarca]
	@idEstatus int,
	@nombreMarca varchar(50),	
	@codigoMarca varchar(20),	
	@piezasMarca int,
	@pesoMarca float,
	@idPlanoDespiece int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 01/Marzo/16
-- Descripcion: Insertar una nueva Marca
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;

	-- Declaracion de variables
	DECLARE  @idMarca int
			,@cont int = 1;
	
	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO [cmiMarcas]
				   ([fechaCreacion]
				   ,[fechaUltModificacion]
				   ,[idEstatus]
				   ,[idPlanoDespiece]
				   ,[codigoMarca]
				   ,[nombreMarca]
				   ,[piezasMarca]
				   ,[pesoMarca]
				   ,[usuarioCreacion])
			 VALUES
				   (getdate()
				   ,getdate()
				   ,@idEstatus
				   ,@idPlanoDespiece
				   ,@codigoMarca
				   ,@nombreMarca
				   ,@piezasMarca
				   ,@pesoMarca
				   ,@usuarioCreacion)

		SET @idMarca = SCOPE_IDENTITY();
		
		-- Serie
		WHILE @cont < @piezasMarca
		BEGIN
		
			INSERT INTO cmiSeries ( idMarca
								   ,idSerie
								   ,idEstatus
								   ,idUsuario )
					VALUES		  ( @idMarca
								   ,[dbo].[ufn_getCodigoSerie] (@cont)
								   ,@idEstatus
								   ,@usuarioCreacion);
			SET @cont = @cont + 1;

		END;

		COMMIT TRANSACTION;
		SELECT @idMarca;
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION;
	END CATCH;	
END;
