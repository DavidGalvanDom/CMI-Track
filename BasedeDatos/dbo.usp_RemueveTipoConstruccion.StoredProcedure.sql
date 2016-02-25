USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoConstruccion]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoConstruccion]
	@idTipoConstruccion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el tipo de construccion
-- Parametros de salida:
-- Parametros de entrada: @idTipoConstruccion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposConstruccion 
    WHERE idTipoConstruccion = @idTipoConstruccion 

END



GO
