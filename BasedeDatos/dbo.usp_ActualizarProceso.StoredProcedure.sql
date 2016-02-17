USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarProceso]    Script Date: 02/17/2016 10:49:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarProceso]
	@IdProceso int,
	@Nombre varchar(50),
	@idTipoProceso int,
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 10/Febrero/16
-- Descripcion: Actualizar Proceso
-- Parametros de salida:
-- Parametros de entrada: @IdGrupo @Nombre @idTipoProceso @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [dbo].[cmiProcesos]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[idEstatus] = @idEstatus
		  ,[nombreProceso] = @Nombre
		  ,[idTipoProceso] = @idTipoProceso
	 WHERE idProceso = @IdProceso

END
GO
