USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarAlmacen]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarAlmacen]
	@IdAlmacen int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Actualizar Almacen
-- Parametros de salida:
-- Parametros de entrada: @IdAlmacen @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiAlmacenes]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreAlmacen] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idAlmacen = @IdAlmacen

END
GO
