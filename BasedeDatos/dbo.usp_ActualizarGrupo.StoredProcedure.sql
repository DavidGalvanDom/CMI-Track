USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarGrupo]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_ActualizarGrupo]
	@IdGrupo int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Actualizar Grupo
-- Parametros de salida:
-- Parametros de entrada: @IdGrupo @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiGrupos]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreGrupo] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idGrupo = @IdGrupo

END







GO
