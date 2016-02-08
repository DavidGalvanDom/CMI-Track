USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposProceso]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposProceso]
	@idTipoProceso int,
	@idEstatus int		
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los tipos de proceso 
-- Parametros de salida:
-- Parametros de entrada:  @idTipoProceso @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idTipoProceso
				,tp.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,tp.idEstatus
				,nombreEstatus
				,nombreTipoProceso	 
	  FROM  cmiTiposProceso as tp
	  inner join cmiEstatus as es on tp.idEstatus = es.idEstatus
	  where idTipoProceso = ISNULL(@idTipoProceso,idTipoProceso)
	  and tp.idEstatus = ISNULL(@idEstatus,tp.idEstatus)
		
END
GO
