USE [CMITrack]
GO

/****** Object:  StoredProcedure [dbo].[usp_RemueveUsuario]    Script Date: 01/30/2016 03:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RemueveUsuario]
	@IdUsuario int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/ ENERO /2016
-- Descripcion: Se deshabilita el usuario
-- Parametros de salida:
-- Parametros de entrada: @IdUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE Usuario 
    WHERE IdUsuario = @IdUsuario 

END

GO

