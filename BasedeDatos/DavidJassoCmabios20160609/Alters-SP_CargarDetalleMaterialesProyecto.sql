
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleMaterialesProyecto]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[usp_CargarDetalleMaterialesProyecto]
	@idRequerimiento int,
	@idEtapa int,
	@idProyecto int	,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga el detalle de materiales asignados a un proyecto etapa
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idRequerimiento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select ROW_NUMBER() OVER(ORDER BY Nombre  DESC) AS Row, Nombre, Ancho, Long, sum(recpie) recpie, sum(reckgs) reckgs, sum(solpie) solpie, sum(solkgs) solkgs, 0 reqpie, 0 reqkgs, sum(matpie) matpie, sum(matkgs) matkgs
from  (select t1.nombreMaterial Nombre, t1.anchoMaterial Ancho, t1.largoMaterial Long,0 recpie, 0 reckgs, 0 solpie, 0 solkgs, sum(cantidadMaterialProyecto) matpie, sum(t0.cantidadMaterialProyecto * (t1.largoMaterial *0.3048) * t1.pesoMaterial) matkgs  
from cmiMaterialesProyecto t0
inner join cmiMateriales t1 on t0.idMaterial = t1.idMaterial 
inner join cmiProyectos t2 on t0.idProyecto = t2.idProyecto
inner join cmiEtapas t3 on t0.idEtapa = t3.idEtapa and t2.idProyecto = t3.idProyecto 
where documentoMaterialProyecto  = @idDocumento
group by  t1.nombreMaterial, t1.anchoMaterial, t1.largoMaterial
union all
select t3.nombreMaterial Nombre, t3.anchoMaterial Ancho, t3.largoMaterial Long,sum(cantidadRecibida) recpie,sum(cantidadRecibida * (t3.largoMaterial *0.3048) * t3.pesoMaterial) reckgs, sum(cantidadSolicitada) solpie, sum(cantidadSolicitada * (t3.largoMaterial *0.3048) * t3.pesoMaterial) solkgs, 0 matpie, 0 matkgs
 from cmiRequisiciones t0
inner join  cmiDetallesRequisicion t1 on t0.idRequisicion = t1.idRequisicion 
inner join cmiRequerimientos t2 on t0.idRequerimiento = t2.idRequerimiento 
inner join cmiMateriales t3 on t1.idMaterial = t3.idMaterial 
inner join cmiEtapas t4 on t2.idEtapa = t4.idEtapa 
inner join cmiProyectos t5 on t4.idProyecto = t5.idProyecto 
where t0.idRequerimiento = @idRequerimiento
and t2.idEtapa = @idEtapa
and t4.idProyecto = @idProyecto
group by  t3.nombreMaterial, t3.anchoMaterial, t3.largoMaterial) t1
group by  Nombre, Ancho, Long

--select  ROW_NUMBER() OVER(ORDER BY ma.nombreMaterial  DESC) AS Row,  ma.nombreMaterial Nombre, ma.anchoMaterial Ancho, ma.largoMaterial Long,  sum(cantidadRecibida) recpie,sum(cantidadRecibida * (ma.largoMaterial *0.3048) * ma.pesoMaterial) reckgs, 
--	sum(cantidadSolicitada) solpie, sum(cantidadSolicitada * (ma.largoMaterial *0.3048) * ma.pesoMaterial) solkgs,
--	0 reqpie, 0 reqkgs,
--	sum(cantidadMaterialProyecto) matpie, sum(cantidadMaterialProyecto * (ma.largoMaterial *0.3048) * ma.pesoMaterial) matkgs
--from cmiMateriales  ma
--inner join cmiDetallesRequisicion dr on ma.idMaterial = dr.idMaterial 
--inner join cmiRequisiciones re on dr.idRequisicion = re.idRequisicion 
--inner join cmiRequerimientos rt on re.idRequerimiento = rt.idRequerimiento
--inner join cmiEtapas et on rt.idEtapa = et.idEtapa
--inner join cmiMaterialesProyecto mp on mp.idEtapa = et.idEtapa
--and mp.idProyecto = et.idProyecto
--and mp.idMaterial = ma.idMaterial
--where re.idRequerimiento = 1
--and rt.idEtapa = 1
--and et.idProyecto = 4
--and mp.idEtapa = 1
--and mp.idProyecto = 4
--and mp.documentoMaterialProyecto = 5
--group by  ma.nombreMaterial, ma.anchoMaterial, ma.largoMaterial

END