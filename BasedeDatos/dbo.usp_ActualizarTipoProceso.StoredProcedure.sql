USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoProceso]    Script Date: 02/13/2016 01:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoProceso]	
	@idTipoProceso int,
	@estatus int,
	@nombreTipoProceso varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el tipo proceso
-- Parametros de salida:
-- Parametros de entrada: @idTipoProceso @usuarioCreacion @estatus @nombreTipoProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiTiposProceso SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreTipoProceso = @nombreTipoProceso
	WHERE idTipoProceso = @idTipoProceso
END
GO
