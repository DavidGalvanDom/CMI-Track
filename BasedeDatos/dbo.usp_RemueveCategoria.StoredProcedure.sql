USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveCategoria]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveCategoria]
	@idCategoria int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita la categoria
-- Parametros de salida:
-- Parametros de entrada: @idCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiCategorias
    WHERE idCategoria = @idCategoria 

END
GO
