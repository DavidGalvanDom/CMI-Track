USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCategoria]    Script Date: 02/13/2016 01:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarCategoria]	
	@idCategoria int,
	@estatus int,
	@nombreCategoria varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza la categoria
-- Parametros de salida:
-- Parametros de entrada: @idCategoria @usuarioCreacion @estatus @nombreCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiCategorias SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreCategoria = @nombreCategoria
	WHERE idCategoria = @idCategoria
END
GO
