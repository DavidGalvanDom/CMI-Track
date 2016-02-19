USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarUnidadMedida]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarUnidadMedida]	
	@NombreCorto varchar(5),
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Insertar un nuevo Unidad de Medida
-- Parametros de salida:
-- Parametros de entrada: @NombreCorto, @Nombre, @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiUnidadesMedida]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreCortoUnidadMedida]
           ,[nombreUnidadMedida])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@NombreCorto
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END
GO
