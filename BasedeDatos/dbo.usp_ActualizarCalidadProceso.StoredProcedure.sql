USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCalidadProceso]    Script Date: 02/17/2016 10:49:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarCalidadProceso]
	@IdProceso int,
	@IdTipoCalidad int,
	@secuencia int,
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Actualizar RutaFabricacion
-- Parametros de salida:
-- Parametros de entrada: @IdProceso @IdTipoCalidad @secuencia @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [dbo].[cmiCalidadProceso]
	   SET  [fechaUltModificacion] = GETDATE()
		   ,[secuenciaCalidadProceso] = @secuencia
		   ,[idEstatus] = @idEstatus
	 WHERE [idProceso] = @idProceso AND [idTipoCalidad] = @IdTipoCalidad

END
GO
