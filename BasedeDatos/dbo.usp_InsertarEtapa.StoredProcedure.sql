USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarEtapa]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[usp_InsertarEtapa]	
	@estatusEtapa int,
	@nombreEtapa varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@idProyecto int,
	@revisionProyecto char(3),
	@infoGeneral varchar(250),	
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 18/Febrero/16
-- Descripcion: Insertar una nueva Etapa al proyecto
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [cmiEtapas]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[idProyecto]
           ,[nombreEtapa]
           ,[estatusEtapa]
           ,[fechaInicioEtapa]
           ,[fechaFinEtapa]
           ,[infGeneralEtapa]
           ,[usuarioCreacion]
           ,[revisionProyecto])
     VALUES
           (GETDATE()           
           ,GETDATE()
           ,1
           ,@idProyecto
           ,@nombreEtapa
           ,@estatusEtapa
           ,convert(datetime, @fechaInicio, 101)
           ,convert(datetime, @fechaFin, 101)
           ,@infoGeneral
           ,@usuarioCreacion
           ,@revisionProyecto)
     
           SELECT SCOPE_IDENTITY()
END
GO
