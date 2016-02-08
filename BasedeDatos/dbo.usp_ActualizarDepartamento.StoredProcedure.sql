USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarDepartamento]    Script Date: 02/07/2016 23:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarDepartamento]
	@idDepartamento int,		
	@idEstatus int,
	@Nombre varchar(255)	
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 06/Febrero/2016
-- Descripcion: Actualiza los datos del Departamento
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE [cmiDepartamentos] SET
					    [idEstatus] = @idEstatus
					   ,[nombreDepartamento] = @Nombre					   
					   ,[fechaUltModificacion] = GETDATE()
     WHERE idDepartamento = @idDepartamento
     
END
GO
