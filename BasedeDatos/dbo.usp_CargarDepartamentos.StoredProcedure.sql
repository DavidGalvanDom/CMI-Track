USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDepartamentos]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarDepartamentos]
	@idDepartamento int,
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Departamentos 
-- Parametros de salida:
-- Parametros de entrada:  @idDepartamento, @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idDepartamento]
		  ,T0.[fechaCreacion]
		  ,T0.[idEstatus]
		  ,T1.[nombreEstatus]
		  ,T0.[nombreDepartamento]
		  ,T0.[usuarioCreacion]
  FROM [cmiDepartamentos] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
   WHERE T0.[idDepartamento] = ISNULL(@idDepartamento,T0.[idDepartamento])
	 and T0.[idEstatus] = ISNULL(@idEstatus,T0.[idEstatus])	
	  
		
END
----------------------
GO
