USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarCategoria]    Script Date: 02/08/2016 16:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarCategoria]	
	@nombreTCategoria varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo categoria
-- Parametros de salida:
-- Parametros de entrada: @nombreTCategoria 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiCategorias
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreCategoria
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,2 
           ,@nombreTCategoria)
           
           SELECT SCOPE_IDENTITY()
END
GO
