USE [CMITrack]
GO

/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarios]    Script Date: 01/30/2016 03:57:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


----------------------
create PROCEDURE [dbo].[usp_CargarUsuarios]
	@IdUsuario int	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Se cargan los usuario 
-- Parametros de salida:
-- Parametros de entrada:  @IdUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT [IdUsuario]		
		  ,[Correo]
		  ,[IdEstatus]
		  ,[Nombre]
		  ,[ApePaterno]
		  ,[ApeMaterno]
		  ,[NombreUsuario]
		  ,[Contrasena]
		  ,[FechaModificacion]
		  ,[FechaCreacion]		 
	  FROM  [Usuario]
	  where IdUsuario = ISNULL(@IdUsuario,IdUsuario)
	  
		
END
----------------------

GO

