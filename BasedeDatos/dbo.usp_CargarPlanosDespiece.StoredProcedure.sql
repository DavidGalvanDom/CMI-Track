USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarPlanosDespiece]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarPlanosDespiece]
	@idPlanoMontaje int,	
	@idPlanoDespiece int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 20/Febrero/16
-- Descripcion: Se cargan los Planos Despiede de un Plano Montaje 
-- Parametros de salida:
-- Parametros de entrada:  @idPlanoMontaje,@idPlanoDespiece,@idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idPlanoDespiece]
		  ,T0.[idPlanoMontaje]
		  ,convert(varchar(10), T0.[fechaCreacion], 101)  fechaCreacion
		  ,T0.[codigoPlanoDespiece]
		  ,T0.[nombrePlanoDespiece]
		  ,T0.[idEstatus]		  
		  ,T0.[infGeneralPlanoDespiece]
		  ,T0.[archivoPlanoDespiece]
		  ,T0.[usuarioCreacion]
		  ,T0.[idTipoConstruccion]
		  ,T1.[nombreEstatus]
	  FROM [cmiPlanosDespiece] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
  WHERE T0.[idPlanoDespiece] = ISNULL(@idPlanoDespiece,T0.[idPlanoDespiece])
  AND T0.[idPlanoMontaje] = ISNULL(@idPlanoMontaje,T0.[idPlanoMontaje])  
  AND T0.[idEstatus] = ISNULL(@idStatus,T0.[idEstatus])
		
END
----------------------

GO
