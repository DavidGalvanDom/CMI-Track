USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRutasFabricacion]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CargarRutasFabricacion]
	@IdRutaFabricacion int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Se cargan las Rutas de Fabricacion
-- Parametros de salida:
-- Parametros de entrada:  @IdRutaFabricacion @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiRutasFabricacion].[idRutaFabricacion]
			,[dbo].[cmiRutasFabricacion].[fechaCreacion]
			,[dbo].[cmiRutasFabricacion].[fechaUltModificacion]
			,[dbo].[cmiRutasFabricacion].[usuarioCreacion]
			,[dbo].[cmiRutasFabricacion].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiRutasFabricacion].[idCategoria]
			,[dbo].[cmiCategorias].[nombreCategoria]
			,[dbo].[cmiRutasFabricacion].[secuenciaRutaFabricacion]
			,[dbo].[cmiRutasFabricacion].[idProceso]
			,[dbo].[cmiProcesos].[nombreProceso]
	FROM [dbo].[cmiRutasFabricacion]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiRutasFabricacion].[idEstatus]
	INNER JOIN [dbo].[cmiCategorias] ON [dbo].[cmiCategorias].[idCategoria] = [dbo].[cmiRutasFabricacion].[idCategoria]
	INNER JOIN [dbo].[cmiProcesos] ON [dbo].[cmiProcesos].[idProceso] = [dbo].[cmiRutasFabricacion].[idProceso]
	WHERE [dbo].[cmiRutasFabricacion].[idRutaFabricacion] = ISNULL(@IdRutaFabricacion, [dbo].[cmiRutasFabricacion].[idRutaFabricacion])
		AND [dbo].[cmiRutasFabricacion].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiRutasFabricacion].[idEstatus])
		
END




GO
