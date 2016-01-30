USE [CMITrack]
GO

/****** Object:  StoredProcedure [dbo].[usp_InsertarUsuario]    Script Date: 01/30/2016 03:57:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_InsertarUsuario]	
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
-- Parametros de entrada: @Correo @Nombre	@ApePaterno @ApeMaterno @NombreUsuario 	@Contrasena 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO [Usuario]
           ([Correo]
           ,[IdEstatus]
           ,[Nombre]
           ,[ApePaterno]
           ,[ApeMaterno]
           ,[NombreUsuario]
           ,[Contrasena]
           ,[FechaModificacion]
           ,[FechaCreacion]
           )
     VALUES
           (@Correo
           ,'ACT'
           ,@Nombre
           ,@ApePaterno 
           ,@ApeMaterno 
           ,@NombreUsuario
           ,@Contrasena 
           ,GETDATE()
           ,GETDATE())
           
           SELECT SCOPE_IDENTITY()
END

GO

