USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveAlmacen]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveAlmacen]
	@IdAlmacen int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/2016
-- Descripcion: Se deshabilita el Almacen
-- Parametros de salida:
-- Parametros de entrada: @IdAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiAlmacenes
    WHERE idAlmacen = @IdAlmacen

END
GO
