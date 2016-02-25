USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposCalidad]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CargarTiposCalidad]
	@IdTipoCalidad int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Tipos de Calidad
-- Parametros de salida:
-- Parametros de entrada:  @IdTipoCalidad @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiTiposCalidad].[idTipoCalidad]
			,[dbo].[cmiTiposCalidad].[fechaCreacion]
			,[dbo].[cmiTiposCalidad].[fechaUltModificacion]
			,[dbo].[cmiTiposCalidad].[usuarioCreacion]
			,[dbo].[cmiTiposCalidad].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiTiposCalidad].[nombreTipoCalidad]
	FROM [dbo].[cmiTiposCalidad]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiTiposCalidad].[idEstatus] = [dbo].[cmiEstatus].[idEstatus]
	WHERE [dbo].[cmiTiposCalidad].[idTipoCalidad] = ISNULL(@IdTipoCalidad, [dbo].[cmiTiposCalidad].[idTipoCalidad])
		AND [dbo].[cmiTiposCalidad].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiTiposCalidad].[idEstatus])
		
END
----------------------




GO
