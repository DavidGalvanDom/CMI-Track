USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarOrigenReq]    Script Date: 02/18/2016 22:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarOrigenReq]	
	@nombreOrigenRequisicion varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Origen
-- Parametros de salida:
-- Parametros de entrada: @nombreOrigenRequisicion   @usuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiOrigenesRequisicion
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreOrigenRequisicion
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1 
           ,@nombreOrigenRequisicion)
           
           SELECT SCOPE_IDENTITY()
END
GO
