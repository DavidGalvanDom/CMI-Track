USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarOrigenReq]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarOrigenReq]	
	@idOrigenRequisicion int,
	@estatus int,
	@nombreOrigenRequisicion varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el origen de la requisicion
-- Parametros de salida:
-- Parametros de entrada: @idOrigenRequisicion @estatus @nombreOrigenRequisicion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiOrigenesRequisicion SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreOrigenRequisicion = @nombreOrigenRequisicion
	WHERE idOrigenRequisicion = @idOrigenRequisicion
END
GO
