USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoProceso]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoProceso]	
	@nombreTipoProceso varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de proceso
-- Parametros de salida:
-- Parametros de entrada: @usuarioCreacion @estatus @nombreTipoProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiTiposProceso
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreTipoProceso
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,2
           ,@nombreTipoProceso)
           
           SELECT SCOPE_IDENTITY()
END
GO
