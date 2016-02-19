USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMaterial]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarMaterial]	
	@nombreMaterial varchar(100),
	@anchoM numeric,
	@idUMAncho int,
	@largoM numeric,
	@idUMLargo int,
	@pesoMaterial numeric,
	@idUMPeso int,
	@calidadMaterial varchar(20),
	@idTipoMaterial int,
	@idGrupo int,
	@observacionesMaterial varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo material
-- Parametros de salida:
-- Parametros de entrada: @nombreMaterial @usuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiMateriales
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreMaterial
		   ,anchoMaterial
			,idUMAncho
			,largoMaterial
			,idUMLargo
			,pesoMaterial
			,idUMPeso
			,calidadMaterial
			,idTipoMaterial
			,idGrupo
			,observacionesMaterial
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1
           ,@nombreMaterial
		   ,@anchoM
		   ,@idUMAncho
		   ,@largoM
		   ,@idUMLargo
		   ,@pesoMaterial
		   ,@idUMPeso
		   ,@calidadMaterial
		   ,@idTipoMaterial
		   ,@idGrupo
		   ,@observacionesMaterial)
           
           SELECT SCOPE_IDENTITY()
END
GO
