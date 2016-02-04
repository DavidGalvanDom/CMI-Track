USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_RegistraPermisos]    Script Date: 02/03/2016 21:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_RegistraPermisos]	
	@idUsuario int,
	@idModulo int,
	@lectura int,
	@escritura int,
	@borrado int,
	@clonado int,
	@idEstatus int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 03/Febrero/2016
-- Descripcion: Registra la informacion del modulo con el usuario
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	IF ( NOT EXISTS (SELECT idUsuario 
					FROM [cmiPermisos] 
					WHERE [idUsuario] = @idUsuario 
					and  [idModulo] = @idModulo))
    BEGIN      
	
		INSERT INTO [cmiPermisos]
           ([idUsuario]
           ,[idModulo]
           ,[fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[lecturaPermiso]
           ,[escrituraPermiso]
           ,[borradoPermiso]
           ,[clonadoPermiso]
           ,[usuarioCreacion])
     VALUES
           (@idUsuario 
           ,@idModulo
           ,getdate()
           ,getdate()
           ,@idEstatus
           ,@lectura
           ,@escritura
           ,@borrado
           ,@clonado
           ,@usuarioCreacion)
    END
    ELSE
    BEGIN	
		UPDATE [cmiPermisos] SET 
				[fechaUltModificacion] = getdate()
			   ,[idEstatus] = @idEstatus
			   ,[lecturaPermiso] = @lectura
			   ,[escrituraPermiso] = @escritura
			   ,[borradoPermiso] = @borrado
			   ,[clonadoPermiso] = @clonado
		WHERE [idUsuario] = @idUsuario 
		and  [idModulo] = @idModulo
	
	END
END
