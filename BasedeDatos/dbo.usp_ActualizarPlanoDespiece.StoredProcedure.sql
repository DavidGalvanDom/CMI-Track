USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarPlanoDespiece]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarPlanoDespiece]
	@idEstatus int,
	@nombrePlanoDespiece varchar(50),	
	@codigoPlanoDespiece varchar(50),
	@infoGeneral varchar(250),
	@archivoPlanoDespiece varchar(100),	
	@idTipoConstruccion int,
	@idPlanoMontaje int,
	@idPlanoDespiece int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/Febrero/16
-- Descripcion: Se actuliza la informacion de Plano Despiece
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
			
	UPDATE  [cmiPlanosDespiece] SET			   
			    [fechaUltModificacion] = GETDATE()
			   ,[idEstatus] = @idEstatus			   
			   ,[codigoPlanoDespiece] = @codigoPlanoDespiece
			   ,[nombrePlanoDespiece] = @nombrePlanoDespiece
			   ,[idTipoConstruccion] = @idTipoConstruccion
			   ,[infGeneralPlanoDespiece] = @infoGeneral
			   ,[archivoPlanoDespiece] = @archivoPlanoDespiece
	 WHERE [idPlanoDespiece] = @idPlanoDespiece
	 and [idPlanoMontaje] = @idPlanoMontaje

END

GO
