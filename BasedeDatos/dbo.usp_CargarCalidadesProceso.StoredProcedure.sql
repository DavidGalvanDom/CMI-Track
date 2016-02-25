USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarCalidadesProceso]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_CargarCalidadesProceso]
	@IdProceso int,
	@idTipoCalidad int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Se cargan las Relaciones Calidad Proceso
-- Parametros de salida:
-- Parametros de entrada:  @IdProceso @idTipoCalidad @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiCalidadProceso].[idProceso]
			,[dbo].[cmiProcesos].[nombreProceso]
			,[dbo].[cmiCalidadProceso].[idTipoCalidad]
			,[dbo].[cmiTiposCalidad].[nombreTipoCalidad]
			,[dbo].[cmiCalidadProceso].[secuenciaCalidadProceso]
			,[dbo].[cmiCalidadProceso].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiCalidadProceso].[usuarioCreacion]
			,[dbo].[cmiCalidadProceso].[fechaCreacion]
			,[dbo].[cmiCalidadProceso].[fechaUltModificacion]
	FROM [dbo].[cmiCalidadProceso]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiCalidadProceso].[idEstatus]
	INNER JOIN [dbo].[cmiTiposCalidad] ON [dbo].[cmiTiposCalidad].[idTipoCalidad] = [dbo].[cmiCalidadProceso].[idTipoCalidad]
	INNER JOIN [dbo].[cmiProcesos] ON [dbo].[cmiProcesos].[idProceso] = [dbo].[cmiCalidadProceso].[idProceso]
	WHERE [dbo].[cmiCalidadProceso].[idProceso] = ISNULL(@IdProceso, [dbo].[cmiCalidadProceso].[idProceso])
		AND [dbo].[cmiCalidadProceso].[idTipoCalidad] = ISNULL(@idTipoCalidad, [dbo].[cmiCalidadProceso].[idTipoCalidad])
		AND [dbo].[cmiCalidadProceso].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiCalidadProceso].[idEstatus])
		
END





GO
