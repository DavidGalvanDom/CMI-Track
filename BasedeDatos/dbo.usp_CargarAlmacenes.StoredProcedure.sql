USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarAlmacenes]    Script Date: 02/17/2016 10:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarAlmacenes]
	@IdAlmacen int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Almacenes
-- Parametros de salida:
-- Parametros de entrada:  @IdAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiAlmacenes].[idAlmacen]
			,[dbo].[cmiAlmacenes].[fechaCreacion]
			,[dbo].[cmiAlmacenes].[fechaUltModificacion]
			,[dbo].[cmiAlmacenes].[usuarioCreacion]
			,[dbo].[cmiAlmacenes].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiAlmacenes].[nombreAlmacen]
	FROM [dbo].[cmiAlmacenes]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiAlmacenes].[idEstatus]
	WHERE [dbo].[cmiAlmacenes].[idAlmacen] = ISNULL(@IdAlmacen, [dbo].[cmiAlmacenes].[idAlmacen])
		AND [dbo].[cmiAlmacenes].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiAlmacenes].[idEstatus])
		
END
GO
