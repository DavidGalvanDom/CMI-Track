USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarGrupo]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarGrupo]	
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Insertar un nuevo Grupo
-- Parametros de salida:
-- Parametros de entrada: @Nombre @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiGrupos]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreGrupo])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END
GO
