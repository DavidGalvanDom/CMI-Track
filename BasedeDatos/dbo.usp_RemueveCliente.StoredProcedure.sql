USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveCliente]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveCliente]
	@idCliente int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el cliente
-- Parametros de salida:
-- Parametros de entrada: @idCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiClientes
    WHERE idCliente = @idCliente

END
GO
