USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarModulosSeguridad]    Script Date: 02/03/2016 21:52:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------
ALTER PROCEDURE [dbo].[usp_CargarModulosSeguridad]	
	@idUsuario int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 01/Febrero/16
-- Descripcion: Se cargan los Modulos del sistema
-- Parametros de salida:
-- Parametros de entrada:  
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT T0.[idModulo]
		  ,T0.[idEstatus]
		  ,T0.[nombreModulo]
		  ,T1.[lecturaPermiso]
		  ,T1.[escrituraPermiso]
		  ,T1.[borradoPermiso]
		  ,T1.[clonadoPermiso]
	  FROM [cmiModulos] T0 
	  LEFT JOIN [cmiPermisos] T1 ON   T0.idModulo = T1.idModulo And
									  T1.idUsuario = @idUsuario and
									  T1.idEstatus = 1
	  WHERE T0.idEstatus = 1
	 	 
		
END
----------------------
