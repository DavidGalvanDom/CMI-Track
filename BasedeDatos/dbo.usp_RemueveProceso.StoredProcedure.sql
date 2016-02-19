USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveProceso]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveProceso]
	@IdProceso int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 10/Febrero/2016
-- Descripcion: Se deshabilita el Proceso
-- Parametros de salida:
-- Parametros de entrada: @IdProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiProcesos
    WHERE idProceso = @IdProceso

END
GO
