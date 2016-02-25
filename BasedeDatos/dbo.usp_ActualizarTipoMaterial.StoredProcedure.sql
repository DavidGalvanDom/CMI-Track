USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMaterial]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ActualizarTipoMaterial]
	@IdTipoMaterial int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Actualizar Tipo de Material
-- Parametros de salida:
-- Parametros de entrada: @IdTipoMaterial @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiTiposMaterial]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreTipoMaterial] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idTipoMaterial = @IdTipoMaterial

END





GO
