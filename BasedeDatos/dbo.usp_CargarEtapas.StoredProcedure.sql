USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarEtapas]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarEtapas]
	@idProyecto int,
	@revisionProyecto char(3),
	@idEtapa int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 18/Febrero/16
-- Descripcion: Se cargan las Etapas de un Proyecto 
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto,@revisionProyecto,@idEtapa,@idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idEtapa]
		  ,convert(varchar(10), T0.[fechaCreacion], 101)  fechaCreacion
		  ,T0.[idProyecto]
		  ,T0.[nombreEtapa]
		  ,T0.[estatusEtapa]
		  ,convert(varchar(10), T0.[fechaInicioEtapa], 101)  fechaInicioEtapa
		  ,convert(varchar(10), T0.[fechaFinEtapa], 101)  fechaFinEtapa
		  ,T0.[infGeneralEtapa]
		  ,T0.[usuarioCreacion]
		  ,T0.[revisionProyecto]
		  ,T1.[nombreEstatus]
	  FROM [cmiEtapas] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[estatusEtapa]
  WHERE T0.[idEtapa] = ISNULL(@idEtapa,T0.[idEtapa])
  AND T0.[idProyecto] = ISNULL(@idProyecto,T0.[idProyecto])
  AND T0.[revisionProyecto] = ISNULL(@revisionProyecto,T0.[revisionProyecto])
  AND T0.[estatusEtapa] = ISNULL(@idStatus,T0.[estatusEtapa])
		
END
----------------------

GO
