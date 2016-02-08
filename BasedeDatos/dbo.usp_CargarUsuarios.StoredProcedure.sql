USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarios]    Script Date: 02/08/2016 16:11:02 ******/
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
	
	SELECT [idUsuario]
      ,[nombreUsuario]
      ,[apePaternoUsuario]
      ,[apeMaternoUsuario]
      ,[puestoUsuario]
      ,[areaUsuario]
      ,[idDepartamento]
      ,[emailUsuario]
      ,[loginUsuario]      
      ,[passwordUsuario]
      ,[autorizaRequisiciones]
      ,[idProcesoOrigen]
      ,[idProcesoDestino]
      ,[fechaCreacion]
	  ,[idEstatus]      
  FROM [cmiUsuarios]
  WHERE idUsuario = ISNULL(@idUsuario,IdUsuario)
	  
		
END
----------------------
GO
