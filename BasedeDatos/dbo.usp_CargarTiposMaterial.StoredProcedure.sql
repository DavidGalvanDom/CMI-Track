USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMaterial]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposMaterial]
	@IdTipoMaterial int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Se cargan los Tipos de Material
-- Parametros de salida:
-- Parametros de entrada:  @IdTipoMaterial, @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiTiposMaterial].[idTipoMaterial]
			,[dbo].[cmiTiposMaterial].[fechaCreacion]
			,[dbo].[cmiTiposMaterial].[fechaUltModificacion]
			,[dbo].[cmiTiposMaterial].[usuarioCreacion]
			,[dbo].[cmiTiposMaterial].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiTiposMaterial].[nombreTipoMaterial]
	FROM [dbo].[cmiTiposMaterial]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiTiposMaterial].[idEstatus] = [dbo].[cmiEstatus].[idEstatus]
	WHERE [dbo].[cmiTiposMaterial].[idTipoMaterial] = ISNULL(@IdTipoMaterial, [dbo].[cmiTiposMaterial].[idTipoMaterial])
		AND [dbo].[cmiTiposMaterial].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiTiposMaterial].[idEstatus])
		
END
----------------------
GO
