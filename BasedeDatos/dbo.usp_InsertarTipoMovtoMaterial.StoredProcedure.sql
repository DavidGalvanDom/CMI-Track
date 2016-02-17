USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoMovtoMaterial]    Script Date: 02/17/2016 10:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoMovtoMaterial]	
	@nombreTipoMovtoMaterial varchar(100),
	@tipoMovtoMaterial varchar(1),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de movimiento de material
-- Parametros de salida:
-- Parametros de entrada: @usuarioCreacion @estatus @nombreTipoMovtoMaterial @tipoMovtoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiTiposMovtoMaterial
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreTipoMovtoMaterial
		   ,tipoMovtoMaterial
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1
           ,@nombreTipoMovtoMaterial
		   ,@tipoMovtoMaterial)
           
           SELECT SCOPE_IDENTITY()
END
GO
