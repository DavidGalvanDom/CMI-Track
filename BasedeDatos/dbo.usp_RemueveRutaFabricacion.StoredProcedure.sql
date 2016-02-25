USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveRutaFabricacion]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RemueveRutaFabricacion]
	@IdRutaFabricacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/2016
-- Descripcion: Se deshabilita la RutaFabricacion
-- Parametros de salida:
-- Parametros de entrada: @IdRutaFabricacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiRutasFabricacion
    WHERE idRutaFabricacion = @IdRutaFabricacion

END









GO
