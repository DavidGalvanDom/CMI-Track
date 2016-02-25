USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoCalidad]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ActualizarTipoCalidad]
	@IdTipoCalidad int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Actualizar Tipo de Calidad
-- Parametros de salida:
-- Parametros de entrada: @IdTipoCalidad @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiTiposCalidad]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreTipoCalidad] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idTipoCalidad = @IdTipoCalidad

END






GO
