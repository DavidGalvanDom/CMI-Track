USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarPlanoMontaje]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarPlanoMontaje]
	@idEstatus int,
	@nombrePlanoMontaje varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@codigoPlanoMontaje varchar(20),
	@infoGeneral varchar(250),
	@archivoPlanoProyecto varchar(100),
	@idEtapa int,
	@idPlanoMontaje int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 22/Febrero/16
-- Descripcion: Actualiza los datos de un Plano de Montaje
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;
			
	UPDATE [cmiPlanosMontaje] SET
            [fechaUltModificacion] = GETDATE()
           ,[idEstatus] = @idEstatus
           ,[idEtapa] = @idEtapa
           ,[codigoPlanoMontaje] = @codigoPlanoMontaje
           ,[nombrePlanoMontaje] = @nombrePlanoMontaje
           ,[fechaInicioPlanoMontaje] = convert(datetime, @fechaInicio, 101)
           ,[fechaFinPlanoMontaje] = convert(datetime, @fechaFin, 101)
           ,[infGeneralPlanoMontaje] = @infoGeneral
           ,[archivoPlanoMontaje] = @archivoPlanoProyecto
     WHERE idPlanoMontaje = @idPlanoMontaje
      

END

GO
