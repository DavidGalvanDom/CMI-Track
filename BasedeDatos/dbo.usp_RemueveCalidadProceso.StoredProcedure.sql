USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveCalidadProceso]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveCalidadProceso]
	@IdProceso int,
	@IdTipoCalidad int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/2016
-- Descripcion: Se deshabilita la CalidadProceso
-- Parametros de salida:
-- Parametros de entrada: @IdProceso @IdTipoCalidad
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiCalidadProceso
    WHERE idProceso = @IdProceso AND idTipoCalidad = @IdTipoCalidad

END
GO
