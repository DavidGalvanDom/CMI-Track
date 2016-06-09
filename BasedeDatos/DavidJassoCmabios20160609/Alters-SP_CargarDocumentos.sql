
/****** Object:  StoredProcedure [dbo].[usp_CargarDocumentos]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[usp_CargarDocumentos]
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Abril/16
-- Descripcion: Se cargan los movimeintos de materiales
-- Parametros de salida:
-- Parametros de entrada:  
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select distinct documentoMovimientoMaterial  from cmiMovimientosMaterial 
order by documentoMovimientoMaterial 


		
END


GO
