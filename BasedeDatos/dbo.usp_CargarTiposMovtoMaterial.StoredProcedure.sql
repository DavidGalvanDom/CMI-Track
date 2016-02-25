USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMovtoMaterial]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposMovtoMaterial]
	@idTipoMovtoMaterial int,
	@idEstatus int		
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los tipos de mterial 
-- Parametros de salida:
-- Parametros de entrada:  @idTipoMovtoMaterial @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idTipoMovtoMaterial
				,tm.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,tm.idEstatus
				,nombreEstatus
				,nombreTipoMovtoMaterial
				,tipoMovtoMaterial	 
	  FROM  cmiTiposMovtoMaterial as tm
	  INNER JOIN cmiEstatus as es on tm.idEstatus = es.idEstatus
	  where idTipoMovtoMaterial = ISNULL(@idTipoMovtoMaterial,idTipoMovtoMaterial)
	  and tm.idEstatus = ISNULL(@idEstatus,tm.idEstatus)
		
END

GO
