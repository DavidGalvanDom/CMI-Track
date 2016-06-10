/****** Object:  StoredProcedure [dbo].[usp_CargarDocumentosMaterialesProyecto]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[usp_CargarDocumentosMaterialesProyecto]
  @idProyecto INT
 ,@idEtapa INT
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga los documetos generados de materiales asignados
-- Parametros de salida:
-- Parametros de entrada:  
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select distinct documentoMaterialProyecto  from cmiMaterialesProyecto 
	where idProyecto = @idProyecto
	and idEtapa = @idEtapa
	order by documentoMaterialProyecto

END

GO
