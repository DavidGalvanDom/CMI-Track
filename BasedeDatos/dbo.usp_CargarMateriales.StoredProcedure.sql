USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMateriales]    Script Date: 02/17/2016 22:22:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarMateriales]
	@idMaterial int,
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Materiales 
-- Parametros de salida:
-- Parametros de entrada:  @idMaterial, @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT [idMaterial]
		  ,ma.[fechaCreacion]
		  ,ma.[idEstatus]
		  ,[nombreEstatus]
		  ,[nombreMaterial]
		  ,[anchoMaterial]
		  ,[idUMAncho]
		  ,[largoMaterial]
		  ,[idUMLargo]
		  ,[pesoMaterial]
		  ,[idUMPeso]
		  ,[calidadMaterial]
		  ,[idTipoMaterial]
		  ,[idGrupo]
		  ,[observacionesMaterial]
		  ,[usuarioCreacion]
  FROM [cmiMateriales] as ma
   inner join cmiEstatus as es on ma.idEstatus = es.idEstatus
   WHERE [idMaterial] = ISNULL(@idMaterial,[idMaterial])
	 and ma.[idEstatus] = ISNULL(@idEstatus,ma.[idEstatus])	
	  
		
END
GO
