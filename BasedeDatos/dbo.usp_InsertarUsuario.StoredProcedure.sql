USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarUsuario]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarUsuario]	
	@idEstatus int,
	@Correo varchar(100),
	@Nombre varchar(50),
	@ApePaterno varchar(50),
	@ApeMaterno varchar(50),
	@NombreUsuario varchar(20),
	@Contrasena varchar(20),
	@Puesto varchar(50),
	@Area varchar(50),
	@idDepto int,
	@Autoriza int,
	@idProOrigen int,
	@idProDestino int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Insertar un nuevo Usuario
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [cmiUsuarios]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[nombreUsuario]
           ,[puestoUsuario]
           ,[areaUsuario]
           ,[idDepartamento]
           ,[emailUsuario]
           ,[loginUsuario]
           ,[passwordUsuario]
           ,[autorizaRequisiciones]
           ,[apePaternoUsuario]
           ,[apeMaternoUsuario]
           ,[idProcesoOrigen]
           ,[idProcesoDestino]
           ,[usuarioCreacion])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@idEstatus
           ,@Nombre
           ,@Puesto
           ,@Area
           ,@idDepto
           ,@Correo
           ,@NombreUsuario 
           ,@Contrasena
           ,@Autoriza
           ,@ApePaterno
           ,@ApeMaterno 
           ,@idProOrigen
           ,@idProDestino
           ,@usuarioCreacion)
           
           SELECT SCOPE_IDENTITY()
END

GO
