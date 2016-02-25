USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarPlanoMontaje]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarPlanoMontaje]
	@idEstatus int,
	@nombrePlanoMontaje varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@codigoPlanoMontaje varchar(20),
	@infoGeneral varchar(250),
	@archivoPlanoProyecto varchar(100),
	@idEtapa int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 22/Febrero/16
-- Descripcion: Insertar un nuevo Plano Montaje
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;
	
	INSERT INTO [cmiPlanosMontaje]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[idEtapa]
           ,[codigoPlanoMontaje]
           ,[nombrePlanoMontaje]
           ,[fechaInicioPlanoMontaje]
           ,[fechaFinPlanoMontaje]
           ,[infGeneralPlanoMontaje]
           ,[archivoPlanoMontaje]
           ,[usuarioCreacion])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@idEstatus
           ,@idEtapa
           ,@codigoPlanoMontaje
           ,@nombrePlanoMontaje
           ,convert(datetime, @fechaInicio, 101)
           ,convert(datetime, @fechaFin, 101)
           ,@infoGeneral
           ,@archivoPlanoProyecto
           ,@usuarioCreacion)

		SELECT SCOPE_IDENTITY()

END

GO
