USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarAlmacen]    Script Date: 02/13/2016 01:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarAlmacen]	
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Almacen
-- Parametros de salida:
-- Parametros de entrada: @Nombre @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiAlmacenes]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreAlmacen])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END
GO
