USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarProcesos]    Script Date: 02/17/2016 10:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarProcesos]
	@IdProceso int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 10/Febrero/16
-- Descripcion: Se cargan los Almacenes
-- Parametros de salida:
-- Parametros de entrada:  @IdProceso @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiProcesos].[idProceso]
			,[dbo].[cmiProcesos].[fechaCreacion]
			,[dbo].[cmiProcesos].[fechaUltModificacion]
			,[dbo].[cmiProcesos].[usuarioCreacion]
			,[dbo].[cmiProcesos].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiProcesos].[nombreProceso]
			,[dbo].[cmiProcesos].[idTipoProceso]
			,[dbo].[cmiTiposProceso].[nombreTipoProceso]
	FROM [dbo].[cmiProcesos]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiProcesos].[idEstatus]
	INNER JOIN [dbo].[cmiTiposProceso] ON [dbo].[cmiTiposProceso].[idTipoProceso] = [dbo].[cmiProcesos].[idTipoProceso]
	WHERE [dbo].[cmiProcesos].[idProceso] = ISNULL(@IdProceso, [dbo].[cmiProcesos].[idProceso])
		AND [dbo].[cmiProcesos].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiProcesos].[idEstatus])
		
END
GO
