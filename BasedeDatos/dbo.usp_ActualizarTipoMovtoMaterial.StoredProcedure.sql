USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMovtoMaterial]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoMovtoMaterial]	
	@idTipoMovtoMaterial int,
	@estatus char(3),
	@nombreTipoMovtoMaterial varchar(100),
	@tipoMovtoMaterial varchar(1)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el Tipo de Movimiento de material
-- Parametros de salida:
-- Parametros de entrada: @idTipoMovtoMaterial @usuarioCreacion @estatus @nombreTipoMovtoMaterial @tipoMovtoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiTiposMovtoMaterial SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreTipoMovtoMaterial = @nombreTipoMovtoMaterial
											   ,tipoMovtoMaterial = @tipoMovtoMaterial
	WHERE idTipoMovtoMaterial = @idTipoMovtoMaterial
END
GO
