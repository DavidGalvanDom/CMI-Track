USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemuevePlanoMontaje]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemuevePlanoMontaje]
	@idPlanoMontaje int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 22/ Febrero /2016
-- Descripcion: So borra de base de datos el Plano montaje
-- Parametros de salida:
-- Parametros de entrada: @idPlanoMontaje
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiPlanosMontaje
    WHERE idPlanoMontaje = @idPlanoMontaje 
    
END

GO
