USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarProceso]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarProceso]	
	@Nombre varchar(50),
	@idTipoProceso int,
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 10/Febrero/16
-- Descripcion: Insertar un nuevo Proceso
-- Parametros de salida:
-- Parametros de entrada: @Nombre @idTipoProceso @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiProcesos]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreProceso]
           ,[idTipoProceso])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre
           ,@idTipoProceso)
           
           SELECT SCOPE_IDENTITY()
END
GO
