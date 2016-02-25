USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarPlanoDespiece]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarPlanoDespiece]
	@idEstatus int,
	@nombrePlanoDespiece varchar(50),	
	@codigoPlanoDespiece varchar(50),
	@infoGeneral varchar(250),
	@archivoPlanoDespiece varchar(100),	
	@idTipoConstruccion int,
	@idPlanoMontaje int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/Febrero/16
-- Descripcion: Insertar un nuevo Plano Despiece
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;

	INSERT INTO [cmiPlanosDespiece]
			   ([fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[idEstatus]
			   ,[idPlanoMontaje]
			   ,[codigoPlanoDespiece]
			   ,[nombrePlanoDespiece]
			   ,[idTipoConstruccion]
			   ,[infGeneralPlanoDespiece]
			   ,[archivoPlanoDespiece]
			   ,[usuarioCreacion])
		 VALUES
			   (GETDATE()
			   ,GETDATE()
			   ,@idEstatus
			   ,@idPlanoMontaje
			   ,@codigoPlanoDespiece
			   ,@nombrePlanoDespiece
			   ,@idTipoConstruccion
			   ,@infoGeneral
			   ,@archivoPlanoDespiece
			   ,@usuarioCreacion)

		SELECT SCOPE_IDENTITY()

END

GO
