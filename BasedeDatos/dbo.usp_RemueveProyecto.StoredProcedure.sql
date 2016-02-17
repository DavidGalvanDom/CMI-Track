USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveProyecto]    Script Date: 02/17/2016 10:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveProyecto]
	@idProyecto int,
	@revision char(3)
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 17/ Febrero /2016
-- Descripcion: So borra de base de datos el proyecto
-- Parametros de salida:
-- Parametros de entrada: @idProyecto,@revision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiProyectos 
    WHERE idProyecto = @idProyecto 
    and revisionProyecto = @revision

END
GO
