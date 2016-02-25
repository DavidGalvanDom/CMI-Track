USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarios]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarUsuarios]
	@idUsuario int	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Se cargan los usuario 
-- Parametros de salida:
-- Parametros de entrada:  @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idUsuario]
      ,T0.[nombreUsuario]
      ,T0.[apePaternoUsuario]
      ,T0.[apeMaternoUsuario]
      ,T0.[puestoUsuario]
      ,T0.[areaUsuario]
      ,T0.[idDepartamento]
      ,T0.[emailUsuario]
      ,T0.[loginUsuario]      
      ,T0.[passwordUsuario]
      ,T0.[autorizaRequisiciones]
      ,T0.[idProcesoOrigen]
      ,T0.[idProcesoDestino]
      ,T0.[fechaCreacion]
	  ,T0.[idEstatus]
	  ,T1.[nombreEstatus]
  FROM [cmiUsuarios] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
  WHERE T0.[idUsuario] = ISNULL(@idUsuario,T0.[idUsuario])
	  
		
END
----------------------

GO
