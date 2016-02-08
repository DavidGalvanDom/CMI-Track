USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarCliente]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarCliente]	
	@nombreCliente varchar(100),
	@direccionEntregaCliente varchar(100),
	@coloniaCliente varchar(100),
	@cpCliente int,
	@ciudadCliente varchar(100),
	@estadoCliente varchar(100),
	@paisCliente varchar(100),
	@contactoCliente varchar(100),
    @usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo CLIENTE
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiClientes
           (fechaCreacion
			,fechaUltModificacion
			,idEstatus
			,nombreCliente
			,direccionEntregaCliente
			,coloniaCliente
			,cpCliente
			,ciudadCliente
			,estadoCliente
			,paisCliente
			,contactoCliente
			,usuarioCreacion
           )
     VALUES
           (GETDATE()
			,GETDATE()
			,2
			,@nombreCliente
			,@direccionEntregaCliente
			,@coloniaCliente
			,@cpCliente
			,@ciudadCliente
			,@estadoCliente
			,@paisCliente
			,@contactoCliente
			,@usuarioCreacion 
           )
           
           SELECT SCOPE_IDENTITY()
END
GO
