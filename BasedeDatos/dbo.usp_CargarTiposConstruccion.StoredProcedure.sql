USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposConstruccion]    Script Date: 02/17/2016 10:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposConstruccion]
	@idTipoConstruccion int,
	@idEstaus int	
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los tipos de construccion 
-- Parametros de salida:
-- Parametros de entrada:  @idTipoConstruccion @idEstaus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idTipoConstruccion
				,tc.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,tc.idEstatus
				,nombreEstatus
				,nombreTipoConstruccion	 
	  FROM  cmiTiposConstruccion as tc
	  inner join cmiEstatus as es on tc.idEstatus = es.idEstatus
	  where idTipoConstruccion = ISNULL(@idTipoConstruccion,idTipoConstruccion)
	  and tc.idEstatus = ISNULL(@idEstaus,tc.idEstatus)
	  
		
END
----------------------
GO
