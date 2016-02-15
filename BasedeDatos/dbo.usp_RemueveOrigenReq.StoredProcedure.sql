USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveOrigenReq]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveOrigenReq]
	@idOrigenRequisicion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el origen de la req
-- Parametros de salida:
-- Parametros de entrada: @idOrigenRequisicion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiOrigenesRequisicion
    WHERE idOrigenRequisicion = @idOrigenRequisicion 

END
GO
