USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUsuario]    Script Date: 02/03/2016 21:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_ActualizarUsuario]
	@idUsuario int,		
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
	@idProDestino int
	
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 03/Febrero/2016
-- Descripcion: Actualiza los datos del Usuario
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE [cmiUsuarios] SET[emailUsuario] = @Correo
					   ,[idEstatus] = @idEstatus
					   ,[nombreUsuario] = @Nombre
					   ,[apePaternoUsuario] = @ApePaterno
					   ,[apeMaternoUsuario] = @ApeMaterno 
					   ,[loginUsuario] = @NombreUsuario
					   ,[passwordUsuario] = @Contrasena 
					   ,[puestoUsuario] = @Puesto
					   ,[areaUsuario] = @Area					   
					   ,[idDepartamento] = @idDepto
					   ,[autorizaRequisiciones] = @Autoriza
					   ,[idProcesoOrigen] = @idProOrigen
					   ,[idProcesoDestino] = @idProDestino					   
					   ,[fechaUltModificacion] = GETDATE()
     WHERE IdUsuario = @IdUsuario
     
END
