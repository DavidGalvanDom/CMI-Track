USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDepartamentos]    Script Date: 02/08/2016 16:11:02 ******/
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
	
	SELECT [idDepartamento]
		  ,[fechaCreacion]
		  ,[idEstatus]
		  ,[nombreDepartamento]
		  ,[usuarioCreacion]
  FROM [cmiDepartamentos]
   WHERE [idDepartamento] = ISNULL(@idDepartamento,[idDepartamento])
	 and [idEstatus] = ISNULL(@idEstatus,[idEstatus])	
	  
		
END
----------------------
GO
