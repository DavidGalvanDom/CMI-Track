USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUnidadMedida]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_ActualizarUnidadMedida]
	@IdUnidadMedida int,
	@NombreCorto varchar(5),
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Actualizar Unidad Medida
-- Parametros de salida:
-- Parametros de entrada: @IdUnidadMedida @NombreCorto @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiUnidadesMedida]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreCortoUnidadMedida] = @NombreCorto
		  ,[nombreUnidadMedida] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idUnidadMedida = @IdUnidadMedida

END




GO
