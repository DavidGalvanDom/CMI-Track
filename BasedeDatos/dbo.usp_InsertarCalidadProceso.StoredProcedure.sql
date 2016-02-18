USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarCalidadProceso]    Script Date: 02/17/2016 22:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarCalidadProceso]	
	@idProceso int,
	@secuencia int,
	@idTipoCalidad int,
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Insertar un nuevo CalidadProceso
-- Parametros de salida:
-- Parametros de entrada: @idProceso @secuencia @idTipoCalidad @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiCalidadProceso]
			   ([idProceso]
			   ,[idTipoCalidad]
			   ,[fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[secuenciaCalidadProceso]
			   ,[idEstatus]
			   ,[usuarioCreacion])
		 VALUES
			   (@idProceso
			   ,@idTipoCalidad
			   ,GETDATE()
			   ,GETDATE()
			   ,@secuencia
			   ,1
			   ,@UsuarioCreacion)
    
	SELECT SCOPE_IDENTITY()
END
GO
