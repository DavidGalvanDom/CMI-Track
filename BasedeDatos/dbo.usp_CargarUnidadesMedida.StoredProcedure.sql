USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUnidadesMedida]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CargarUnidadesMedida]
	@IdUnidadMedida int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Se cargan las unidades de medida
-- Parametros de salida:
-- Parametros de entrada:  @IdUnidadMedida, @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiUnidadesMedida].[idUnidadMedida]
			,[dbo].[cmiUnidadesMedida].[fechaCreacion]
			,[dbo].[cmiUnidadesMedida].[fechaUltModificacion]
			,[dbo].[cmiUnidadesMedida].[usuarioCreacion]
			,[dbo].[cmiUnidadesMedida].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiUnidadesMedida].[nombreCortoUnidadMedida]
			,[dbo].[cmiUnidadesMedida].[nombreUnidadMedida]
	FROM [dbo].[cmiUnidadesMedida]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiUnidadesMedida].[idEstatus] = [dbo].[cmiEstatus].[idEstatus]
	WHERE [dbo].[cmiUnidadesMedida].[idUnidadMedida] = ISNULL(@IdUnidadMedida, [dbo].[cmiUnidadesMedida].[idUnidadMedida]) 
		AND [dbo].[cmiUnidadesMedida].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiUnidadesMedida].[idEstatus])
		
END
----------------------




GO
