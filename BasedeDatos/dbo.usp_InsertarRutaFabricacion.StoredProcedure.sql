USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarRutaFabricacion]    Script Date: 02/17/2016 10:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarRutaFabricacion]	
	@idCategoria int,
	@secuencia int,
	@idProceso int,
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Insertar un nuevo Proceso
-- Parametros de salida:
-- Parametros de entrada: @idCategoria @secuencia @idProceso @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiRutasFabricacion]
			   ([fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[idEstatus]
			   ,[usuarioCreacion]
			   ,[idCategoria]
			   ,[secuenciaRutaFabricacion]
			   ,[idProceso])
		 VALUES
			   (GETDATE()
			   ,GETDATE()
			   ,1
			   ,@UsuarioCreacion
			   ,@idCategoria
			   ,@secuencia
			   ,@idProceso)
    
	SELECT SCOPE_IDENTITY()
END
GO
