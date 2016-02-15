USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveMaterial]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveMaterial]
	@idMaterial int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el material
-- Parametros de salida:
-- Parametros de entrada: @idMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiMateriales
    WHERE idMaterial = @idMaterial 

END
GO
