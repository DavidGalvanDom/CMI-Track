USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarioPermisos]    Script Date: 02/07/2016 23:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarUsuarioPermisos]	
	@idUsuario int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 05/Febrero/2016
-- Descripcion: Se cargan los permisos del usuario 
-- Parametros de salida:
-- Parametros de entrada:  @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idModulo], 
			T0.[lecturaPermiso], 
			T0.[escrituraPermiso], 
			T0.[borradoPermiso], 
			T0.[clonadoPermiso],
			T1.[urlModulo],
			T1.[nombreModulo],
			T3.[idMenuGrupo],
			T3.[nombreMenuGrupo],
			T3.[iconGrupo]
	FROM [cmiPermisos] T0
	INNER JOIN [cmiModulos] T1 on T1.idModulo = T0.idModulo
	INNER JOIN [cmiModuloMenuGrupo] T2 on T2.idModulo = T0.idModulo
	INNER JOIN [cmiMenuGrupo] T3 on T3.idMenuGrupo = T2.idMenuGrupo
	WHERE T0.[idUsuario] = @idUsuario
	AND T0.[idEstatus] = 1
	AND T0.[lecturaPermiso] = 1
	ORDER BY T1.ordenModulo
		
END
----------------------
GO
