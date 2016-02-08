USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMaterial]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoMaterial]
	@IdTipoMaterial int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/2016
-- Descripcion: Se deshabilita el Tipo de Material
-- Parametros de salida:
-- Parametros de entrada: @IdTipoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposMaterial
    WHERE idTipoMaterial = @IdTipoMaterial

END
GO
