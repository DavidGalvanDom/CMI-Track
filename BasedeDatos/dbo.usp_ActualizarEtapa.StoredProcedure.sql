USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarEtapa]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarEtapa]	
	@estatusEtapa int,
	@nombreEtapa varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),	
	@infoGeneral varchar(250),	
	@idEtapa int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 20/Febrero/16
-- Descripcion: Se actualiza la informacion de la Etapa
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [cmiEtapas] SET           
           [fechaUltModificacion] = GETDATE()           
           ,[nombreEtapa] = @nombreEtapa
           ,[estatusEtapa] = @estatusEtapa
           ,[fechaInicioEtapa] = convert(datetime, @fechaInicio, 101)
           ,[fechaFinEtapa] = convert(datetime, @fechaInicio, 101)
           ,[infGeneralEtapa] = @infoGeneral
     WHERE idEtapa =  @idEtapa
     
END

GO
