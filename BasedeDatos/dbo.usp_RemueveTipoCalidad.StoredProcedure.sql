USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoCalidad]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_RemueveTipoCalidad]
	@IdTipoCalidad int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/2016
-- Descripcion: Se deshabilita el Tipo de Calidad
-- Parametros de salida:
-- Parametros de entrada: @IdTipoCalidad
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposCalidad
    WHERE idTipoCalidad = @IdTipoCalidad

END






GO
