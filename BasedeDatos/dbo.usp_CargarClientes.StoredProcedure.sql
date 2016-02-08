USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarClientes]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarClientes]
	@idCliente int,
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los clientes
-- Parametros de salida:
-- Parametros de entrada:  @idCliente @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idCliente
				,cl.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,cl.idEstatus
				,nombreEstatus
				,nombreCliente
				,direccionEntregaCliente
				,coloniaCliente
				,cpCliente
				,ciudadCliente
				,estadoCliente
				,paisCliente
				,contactoCliente	 
	  FROM  cmiClientes as cl
	  inner join cmiEstatus as es on cl.idEstatus = es.idEstatus
	  where idCliente = ISNULL(@idCliente,idCliente)
	  and cl.idEstatus = ISNULL(@idEstatus,cl.idEstatus)
		
END
GO
