USE [CMITrack]
GO

/****** Object:  StoredProcedure [dbo].[usp_ActualizarUsuario]    Script Date: 01/30/2016 03:56:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ActualizarUsuario]
	@IdUsuario int,		
	@Estatus char(3),
	@Correo varchar(100),
	@Nombre varchar(50),
	@ApePaterno varchar(50),
	@ApeMaterno varchar(50),
	@NombreUsuario varchar(20),
	@Contrasena varchar(20)
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Insertar un nuevo Usuario
-- Parametros de salida:
-- Parametros de entrada: @IdUsuario  @Correo @Estatus  @Nombre	@ApePaterno @ApeMaterno @NombreUsuario 	@Contrasena 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE [Usuario] SET[Correo] = @Correo
					   ,[IdEstatus] = @Estatus
					   ,[Nombre] = @Nombre
					   ,[ApePaterno] = @ApePaterno
					   ,[ApeMaterno] = @ApeMaterno 
					   ,[NombreUsuario] = @NombreUsuario
					   ,[Contrasena] = @Contrasena 
					   ,[FechaModificacion] = GETDATE()
     WHERE IdUsuario = @IdUsuario
     
END

GO

