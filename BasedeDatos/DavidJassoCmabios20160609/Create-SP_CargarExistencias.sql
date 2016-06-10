/****** Object:  StoredProcedure [dbo].[usp_CargarExistencias]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarExistencias]
	@idMaterial int,	
	@idAlmacen int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan el REPORTE DE EXISTENCIAS
-- Parametros de salida:
-- Parametros de entrada:  @idMaterial @idAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select  ROW_NUMBER() over(order by t0.idMaterial) rank,t4.nombreGrupo,t0.idMaterial,t1.nombreMaterial, t1.anchoMaterial, t2.nombreCortoUnidadMedida nombreCortoUnidadMedidaAncho, t1.largoMaterial, t3.nombreCortoUnidadMedida nombreCortoUnidadMedidaLargo, t1.calidadMaterial, t0.cantidadInventario from 
	cmiInventarios t0 
	inner join cmiMateriales t1 on t0.idMaterial = t1.idMaterial 
	inner join cmiUnidadesMedida t2 on t1.idUMAncho = t2.idUnidadMedida
	inner join cmiUnidadesMedida t3 on t1.idUMLargo = t3.idUnidadMedida
	inner join cmiGrupos t4 on t1.idGrupo = t4.idGrupo 
	where t0.idMaterial = ISNULL(@idMaterial,t0.idMaterial)
	and t0.idAlmacen = ISNULL(@idAlmacen, t0.idAlmacen)	
END


GO