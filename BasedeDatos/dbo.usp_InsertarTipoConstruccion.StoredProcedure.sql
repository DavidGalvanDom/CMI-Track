USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoConstruccion]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoConstruccion]	
	@nombreTipoConstruccion varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de construcción
-- Parametros de salida:
-- Parametros de entrada: @idTipoConstruccion @usuarioCreacion @estatus @nombreTipoConstruccion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiTiposConstruccion
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreTipoConstruccion
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,2 
           ,@nombreTipoConstruccion)
           
           SELECT SCOPE_IDENTITY()
END
GO
