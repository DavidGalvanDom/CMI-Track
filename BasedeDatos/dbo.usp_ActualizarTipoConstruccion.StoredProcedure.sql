USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoConstruccion]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoConstruccion]	
	@idTipoConstruccion int,
	@estatus int,
	@nombreTipoConstruccion varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el Tipo de construcción
-- Parametros de salida:
-- Parametros de entrada: @idTipoConstruccion @usuarioCreacion @estatus @nombreTipoConstruccion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiTiposConstruccion SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreTipoConstruccion = @nombreTipoConstruccion
	WHERE idTipoConstruccion = @idTipoConstruccion
END
GO
