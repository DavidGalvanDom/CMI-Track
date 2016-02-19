USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarProyecto]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarProyecto]	
	@idEstatus int,
	@nombreProyecto varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@codigoProyecto varchar(20),
	@revisionProyecto varchar(3),
	@fechaRevision varchar(10),
	@idCategoria int,
	@estatusProyecto int,
	@idCliente int,
	@infoGeneral varchar(250),
	@archivoPlanoProyecto varchar(60),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 15/Febrero/16
-- Descripcion: Insertar un nuevo Proyecto
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	DECLARE @idProyecto int
	BEGIN TRAN
	SELECT @idProyecto = max(Datos) + 1 
	FROM cmiVarControl
	WHERE Clave = 'TBL' 
	AND Consecutivo = 'PRO'
		
	SET NOCOUNT ON;
	
	INSERT INTO [cmiProyectos]
           ([idProyecto]
           ,[fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[codigoProyecto]
           ,[revisionProyecto]
           ,[nombreProyecto]
           ,[fechaRevision]
           ,[idCategoria]
           ,[estatusProyecto]
           ,[fechaInicioProyecto]
           ,[fechaFinProyecto]
           ,[idCliente]
           ,[archivoPlanoProyecto]
           ,[infGeneralProyecto]
           ,[usuarioCreacion])
     VALUES
           (@idProyecto
           ,GETDATE()
           ,GETDATE()
           ,@idEstatus
           ,@codigoProyecto
           ,@revisionProyecto
           ,@nombreProyecto
           ,convert(datetime, @fechaRevision, 101)
           ,@idCategoria
           ,@estatusProyecto
           ,convert(datetime, @fechaInicio, 101)
           ,convert(datetime, @fechaFin, 101)
           ,@idCliente
           ,@archivoPlanoProyecto
           ,@infoGeneral
           ,@usuarioCreacion)

    UPDATE cmiVarControl SET Datos = @idProyecto 
	WHERE Clave = 'TBL' 
	AND Consecutivo = 'PRO'
	
	COMMIT
	
	SELECT @idProyecto
END
GO
