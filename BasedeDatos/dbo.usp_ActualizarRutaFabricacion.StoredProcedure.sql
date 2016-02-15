USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarRutaFabricacion]    Script Date: 02/13/2016 01:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarRutaFabricacion]
	@IdRutaFabricacion int,
	@idCategoria int,
	@secuencia int,
	@idProceso int,
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Actualizar RutaFabricacion
-- Parametros de salida:
-- Parametros de entrada: @IdRutaFabricacion @idCategoria @secuencia @idProceso @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [dbo].[cmiRutasFabricacion]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[idEstatus] = @idEstatus
		  ,[idCategoria] = @idCategoria
		  ,[secuenciaRutaFabricacion] = @secuencia
		  ,[idProceso] = @idProceso
	 WHERE idRutaFabricacion = @IdRutaFabricacion

END
GO
