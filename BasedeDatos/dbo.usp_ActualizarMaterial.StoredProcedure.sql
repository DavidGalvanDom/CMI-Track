USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarMaterial]    Script Date: 02/17/2016 10:49:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarMaterial]	
	@idMaterial int,
	@estatus int,
	@nombreMaterial varchar(100),
	@anchoM numeric,
	@idUMAncho int,
	@largoM numeric,
	@idUMLargo int,
	@pesoMaterial numeric,
	@idUMPeso int,
	@calidadMaterial varchar(20),
	@idTipoMaterial int,
	@idGrupo int,
	@observacionesMaterial varchar(100)

AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el Material
-- Parametros de salida:
-- Parametros de entrada: @idMaterial @estatus @nombreMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiMateriales SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreMaterial = @nombreMaterial
											   ,anchoMaterial = @anchoM
											   ,idUMAncho = @idUMAncho
											   ,largoMaterial = @largoM
											   ,idUMLargo = @idUMLargo
											   ,pesoMaterial = @pesoMaterial
											   ,idUMPeso = @idUMPeso
											   ,calidadMaterial = @calidadMaterial
											   ,idTipoMaterial = @idTipoMaterial
											   ,idGrupo = @idGrupo
											   ,observacionesMaterial = @observacionesMaterial
	WHERE idMaterial = @idMaterial
END
GO
