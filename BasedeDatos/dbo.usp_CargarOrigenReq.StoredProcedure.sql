USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarOrigenReq]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarOrigenReq]
	@idOrigenRequisicion int,	
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan las origenes de requisicion
-- Parametros de salida:
-- Parametros de entrada:  @idOrigenRequisicion @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idOrigenRequisicion
				,ori.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,ori.idEstatus
				,nombreEstatus
				,nombreOrigenRequisicion	 
	  FROM  cmiOrigenesRequisicion as ori
	  inner join cmiEstatus as es on ori.idEstatus = es.idEstatus
	  where idOrigenRequisicion = ISNULL(@idOrigenRequisicion,idOrigenRequisicion)
	  and ori.idEstatus = ISNULL(@idEstatus,ori.idEstatus)
	  
		
END
GO
