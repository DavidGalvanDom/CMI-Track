USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarDepartamento]    Script Date: 02/17/2016 22:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarDepartamento]	
	@idEstatus int,
	@Nombre varchar(255),	
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 06/Febrero/2016
-- Descripcion: Insertar un nuevo Departamento
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [cmiDepartamentos]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[nombreDepartamento]
           ,[usuarioCreacion])
     VALUES
           (getdate()
           ,getdate()
           ,@idEstatus
           ,@Nombre
           ,@usuarioCreacion)
          
           SELECT SCOPE_IDENTITY()
END
GO
