USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_BuscaLoginUsuario]    Script Date: 02/17/2016 22:22:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_BuscaLoginUsuario]	
	@loginUsuario varchar(20),
	@idUsuario int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 08/Febrero/2016
-- Descripcion: Se valida si existe el login de usuario
-- Parametros de salida:
-- Parametros de entrada:  @loginUsuario, @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	if(@idUsuario is null)
		SELECT loginUsuario
		FROM  cmiUsuarios
		WHERE loginUsuario = @loginUsuario
	else
		SELECT loginUsuario
		FROM  cmiUsuarios
		WHERE  idUsuario <> @idUsuario
		and  loginUsuario = @loginUsuario
			
END
GO
