USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarGrupos]    Script Date: 02/17/2016 10:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarGrupos]
	@IdGrupo int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Grupos
-- Parametros de salida:
-- Parametros de entrada:  @IdGrupo @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiGrupos].[idGrupo]
			,[dbo].[cmiGrupos].[fechaCreacion]
			,[dbo].[cmiGrupos].[fechaUltModificacion]
			,[dbo].[cmiGrupos].[usuarioCreacion]
			,[dbo].[cmiGrupos].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiGrupos].[nombreGrupo]
	FROM [dbo].[cmiGrupos]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiGrupos].[idEstatus]
	WHERE [dbo].[cmiGrupos].[idGrupo] = ISNULL(@IdGrupo, [dbo].[cmiGrupos].[idGrupo]) 
		AND [dbo].[cmiGrupos].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiGrupos].[idEstatus])

		
END
GO
