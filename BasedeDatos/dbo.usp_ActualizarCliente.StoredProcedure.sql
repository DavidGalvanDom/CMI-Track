USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCliente]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarCliente]	
	@idCliente int,
	@estatus int,
	@nombreCliente varchar(100),
	@direccionEntregaCliente varchar(100),
	@coloniaCliente varchar(100),
	@cpCliente int,
	@ciudadCliente varchar(100),
	@estadoCliente varchar(100),
	@paisCliente varchar(100),
	@contactoCliente varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza la categoria
-- Parametros de salida:
-- Parametros de entrada: @idCategoria @usuarioCreacion @estatus @nombreCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiClientes SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreCliente = @nombreCliente
											   ,direccionEntregaCliente = @direccionEntregaCliente
											   ,coloniaCliente = @coloniaCliente
											   ,cpCliente = @cpCliente
											   ,ciudadCliente = @ciudadCliente
											   ,estadoCliente = @estadoCliente
											   ,paisCliente = @paisCliente
											   ,contactoCliente = @contactoCliente
	WHERE idCliente = @idCliente
END
GO
