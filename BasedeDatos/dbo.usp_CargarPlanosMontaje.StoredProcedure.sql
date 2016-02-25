USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarPlanosMontaje]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarPlanosMontaje]
	@idEtapa int,	
	@idPlanoMontaje int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 20/Febrero/16
-- Descripcion: Se cargan los Planos Montaje de una Etapa 
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa,@idPlanoMontaje,@idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idPlanoMontaje]
		  ,T0.[idEtapa]
		  ,convert(varchar(10), T0.[fechaCreacion], 101)  fechaCreacion
		  ,T0.[codigoPlanoMontaje]
		  ,T0.[nombrePlanoMontaje]
		  ,T0.[idEstatus]
		  ,convert(varchar(10), T0.[fechaInicioPlanoMontaje], 101)  fechaInicioPlanoMontaje
		  ,convert(varchar(10), T0.[fechaFinPlanoMontaje], 101)  fechaFinPlanoMontaje
		  ,T0.[infGeneralPlanoMontaje]
		  ,T0.[archivoPlanoMontaje]
		  ,T0.[usuarioCreacion]
		  ,T1.[nombreEstatus]
	  FROM [cmiPlanosMontaje] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
  WHERE T0.[idPlanoMontaje] = ISNULL(@idPlanoMontaje,T0.[idPlanoMontaje])
  AND T0.[idEtapa] = ISNULL(@idEtapa,T0.[idEtapa])  
  AND T0.[idEstatus] = ISNULL(@idStatus,T0.[idEstatus])
		
END
----------------------

GO
