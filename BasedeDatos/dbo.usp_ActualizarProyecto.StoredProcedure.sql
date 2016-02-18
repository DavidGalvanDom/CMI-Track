USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarProyecto]    Script Date: 02/17/2016 22:22:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarProyecto]	
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
	@archivoPlanoProyecto varchar(100),
	@usuarioCreacion int,
	@idProyecto int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 16/Febrero/16
-- Descripcion: Actualiza la informacion del Proyecto
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [cmiProyectos] SET
						 [fechaUltModificacion] = GETDATE()
						,[codigoProyecto] = @codigoProyecto
						,[nombreProyecto] = @nombreProyecto
						,[idCategoria] = @idCategoria
						,[fechaInicioProyecto] = convert(datetime, @fechaInicio, 101)
						,[fechaFinProyecto] = convert(datetime, @fechaFin, 101)
						,[estatusProyecto] = @estatusProyecto
						,[idCliente] = @idCliente
						,[archivoPlanoProyecto] = @archivoPlanoProyecto
						,[infGeneralProyecto] = @infoGeneral
	WHERE [idProyecto] = @idProyecto
	AND [revisionProyecto] = @revisionProyecto
           
   
END
GO
