
/****** Object:  StoredProcedure [dbo].[usp_CargarKardex]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[usp_CargarKardex]
	@idMaterial int,	
	@idAlmacen int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan el kardex
-- Parametros de salida:
-- Parametros de entrada:  @idMaterial @idAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select ROW_NUMBER() over(order by ka.idMaterial, ka.fechaCreacion) rank, gr.nombreGrupo, ka.idMaterial,ma.nombreMaterial, al.nombreAlmacen  , ka.documentoKardex, tm.nombreTipoMovtoMaterial, 
	tm.tipoMovtoMaterial, case when tipoMovtoMaterial = 'S' then - ka.cantidadKardex else ka.cantidadKardex end cantidadKardex, ka.fechaCreacion, ma.anchoMaterial, ma.largoMaterial 
	, inv.cantidadInventario from cmiKardex ka
	inner join cmiMateriales ma on ka.idMaterial = ma.idMaterial 
	inner join cmiAlmacenes al on ka.idAlmacen = al.idAlmacen 
	inner join cmiTiposMovtoMaterial tm on ka.idTipoMovtoMaterial = tm.idTipoMovtoMaterial
	inner join cmiGrupos gr on ma.idGrupo = gr.idGrupo 
	inner join cmiInventarios inv on ka.idMaterial = inv.idMaterial and ka.idAlmacen = inv.idAlmacen 
	where ka.idMaterial = ISNULL(@idMaterial,ka.idMaterial)
	and ka.idAlmacen = ISNULL(@idAlmacen, ka.idAlmacen)
	order by ka.idMaterial, ka.fechaCreacion asc
	  
		
END


GO