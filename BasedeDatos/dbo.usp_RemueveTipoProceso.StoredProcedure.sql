USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoProceso]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoProceso]
	@idTipoProceso int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el tipo de proceso
-- Parametros de salida:
-- Parametros de entrada: @idTipoProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposProceso 
    WHERE idTipoProceso = @idTipoProceso

END
GO
