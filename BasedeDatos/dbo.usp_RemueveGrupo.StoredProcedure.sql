USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveGrupo]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveGrupo]
	@IdGrupo int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/2016
-- Descripcion: Se deshabilita el Grupo
-- Parametros de salida:
-- Parametros de entrada: @IdGrupo
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiGrupos
    WHERE idGrupo = @IdGrupo

END
GO
