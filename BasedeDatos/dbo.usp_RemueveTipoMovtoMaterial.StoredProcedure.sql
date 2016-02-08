USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMovtoMaterial]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoMovtoMaterial]
	@idTipoMovtoMaterial int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el tipo de movimiento material
-- Parametros de salida:
-- Parametros de entrada: @idTipoMovtoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposMovtoMaterial 
    WHERE idTipoMovtoMaterial = @idTipoMovtoMaterial 

END
GO
