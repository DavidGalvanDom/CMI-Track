USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_AutentificaUsuario]    Script Date: 02/03/2016 21:50:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_AutentificaUsuario]
	@loginUsuario varchar(20),
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Autentifica al usuario para entrar al sistema
-- Parametros de salida:
-- Parametros de entrada: @idUsuario, @idEstatus
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
  FROM [cmiUsuarios]
  WHERE loginUsuario = @loginUsuario
	and idEstatus = @idEstatus

    
END
