USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveUsuario]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveUsuario]
	@idUsuario int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/ ENERO /2016
-- Descripcion: Se deshabilita el usuario
-- Parametros de salida:
-- Parametros de entrada: @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiUsuarios 
    WHERE idUsuario = @idUsuario 

END

GO
