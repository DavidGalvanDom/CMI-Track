USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveEtapa]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveEtapa]
	@idEtapa int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 20/ Febrero /2016
-- Descripcion: So borra de base de datos la Etapa
-- Parametros de salida:
-- Parametros de entrada: @idEtapa
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiEtapas
    WHERE idEtapa = @idEtapa
    

END

GO
