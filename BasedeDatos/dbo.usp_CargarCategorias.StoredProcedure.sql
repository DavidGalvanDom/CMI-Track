USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarCategorias]    Script Date: 02/17/2016 22:22:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarCategorias]
	@idCategoria int,	
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan las categorias
-- Parametros de salida:
-- Parametros de entrada:  @idCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idCategoria
				,ca.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,ca.idEstatus
				,nombreEstatus
				,nombreCategoria	 
	  FROM  cmiCategorias as ca
	  inner join cmiEstatus as es on ca.idEstatus = es.idEstatus
	  where idCategoria = ISNULL(@idCategoria,idCategoria)
	  and ca.idEstatus = ISNULL(@idEstatus,ca.idEstatus)
	  
		
END
GO
