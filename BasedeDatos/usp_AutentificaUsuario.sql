USE [CMITrack]
GO

/****** Object:  StoredProcedure [dbo].[usp_AutentificaUsuario]    Script Date: 01/30/2016 03:57:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_AutentificaUsuario]
	@IdUsuario varchar(50),
	@Estatus char(3)	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Autentifica al usuario para entrar al sistema
-- Parametros de salida:
-- Parametros de entrada: IdUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT IdUsuario,
		   Nombre,
		   ApePaterno, 
		   ApeMaterno,
		   Contrasena,
		   FechaModificacion, 
		   FechaCreacion, 		  
		   NombreUsuario
	FROM Usuario 	
	WHERE NombreUsuario = @IdUsuario 
	and IdEstatus = @Estatus
    
END

GO

