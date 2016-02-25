USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemuevePlanoDespiece]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemuevePlanoDespiece]
	@idPlanoDespiece int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/ Febrero /2016
-- Descripcion: So borra de base de datos el Plano Despiece
-- Parametros de salida:
-- Parametros de entrada: @idPlanoDespiece
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiPlanosDespiece
    WHERE idPlanoDespiece = @idPlanoDespiece 
    
END

GO
