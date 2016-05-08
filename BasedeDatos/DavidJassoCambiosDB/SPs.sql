USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleMaterialesProyecto]    Script Date: 06/05/2016 10:03:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarDetalleMaterialesProyecto]
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


select  ROW_NUMBER() OVER(ORDER BY ma.nombreMaterial  DESC) AS Row,  ma.nombreMaterial Nombre, ma.anchoMaterial Ancho, ma.largoMaterial Long,  sum(cantidadRecibida) recpie,sum(cantidadRecibida * (ma.largoMaterial *0.3048) * ma.pesoMaterial) reckgs, 
	sum(cantidadSolicitada) solpie, sum(cantidadSolicitada * (ma.largoMaterial *0.3048) * ma.pesoMaterial) solkgs,
	0 reqpie, 0 reqkgs,
	sum(cantidadMaterialProyecto) matpie, sum(cantidadMaterialProyecto * (ma.largoMaterial *0.3048) * ma.pesoMaterial) matkgs
from cmiMateriales  ma
inner join cmiDetallesRequisicion dr on ma.idMaterial = dr.idMaterial 
inner join cmiRequisiciones re on dr.idRequisicion = re.idRequisicion 
inner join cmiRequerimientos rt on re.idRequerimiento = rt.idRequerimiento
inner join cmiEtapas et on rt.idEtapa = et.idEtapa
inner join cmiMaterialesProyecto mp on mp.idEtapa = et.idEtapa
and mp.idProyecto = et.idProyecto
and mp.idMaterial = ma.idMaterial
where re.idRequerimiento = @idRequerimiento
and rt.idEtapa = @idEtapa
and et.idProyecto = @idProyecto
and mp.idEtapa = @idEtapa
and mp.idProyecto = @idProyecto
and mp.documentoMaterialProyecto = @idDocumento
group by  ma.nombreMaterial, ma.anchoMaterial, ma.largoMaterial

END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDocumentosMaterialesProyecto]    Script Date: 06/05/2016 10:03:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarDocumentosMaterialesProyecto]
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

END






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarHeaderMaterialesProyecto]    Script Date: 06/05/2016 10:03:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarHeaderMaterialesProyecto]
	@idProyecto int,
	@idEtapa int,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Abril/16
-- Descripcion: Se cargan el header de materiales asignados al proyecto
-- Parametros de salida:
-- Parametros de entrada: @idProyecto @idEtapa @idDocumento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select distinct documentoMaterialProyecto, et.idEtapa, et.nombreEtapa, mp.idProyecto ,  pr.nombreProyecto, us.nombreUsuario 
from cmiMaterialesProyecto  mp
inner join cmiEtapas et on et.idEtapa = mp.idEtapa 
inner join cmiProyectos pr on pr.idProyecto = mp.idProyecto
inner join cmiUsuarios us on us.idUsuario = mp.usuarioCreacion  
where mp.idProyecto = @idProyecto
and mp.idEtapa = @idEtapa
and mp.documentoMaterialProyecto = @idDocumento 


END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMaterialesAsignados]    Script Date: 06/05/2016 10:03:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMaterialesAsignados]
	@idProyecto int,	
	@idEtapa int,
	@idRequerimiento int,
	@idAlmacen int,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga el detalle de materiales asignados a un proyecto etapa
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idAlmacen @idRequerimiento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select mp.idMaterialProyecto, mp.idMaterial, ma.nombreMaterial, um.nombreCortoUnidadMedida, inv.cantidadInventario,
		0 cantidadEntrega,	ma.calidadMaterial, ma.anchoMaterial, ma.largoMaterial, ma.largoMaterial * 0.3048 LongArea, ma.pesoMaterial,
	(mp.cantidadMaterialProyecto * (ma.largoMaterial * 0.3048) * ma.pesoMaterial) Total
	 from cmiMaterialesProyecto mp
	INNER JOIN cmiMateriales ma ON mp.idMaterial = ma.idMaterial
	INNER JOIN cmiUnidadesMedida um ON mp.idUnidadMedida = um.idUnidadMedida 
	INNER JOIN cmiInventarios inv on mp.idMaterial = inv.idMaterial
	where mp.idProyecto = @idProyecto
	and mp.idEtapa = @idEtapa
	and inv.idAlmacen = @idAlmacen
	and mp.documentoMaterialProyecto  = @idDocumento



END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMaterialesProyecto]    Script Date: 06/05/2016 10:03:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMaterialesProyecto]
	@idProyecto int,	
	@idEtapa int,
	@idMatPro int,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga el detalle de materiales asignados a un proyecto etapa
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select idMaterialProyecto, mp.idMaterial, ma.nombreMaterial, um.nombreCortoUnidadMedida, inv.cantidadInventario,
	CASE WHEN mp.cantidadMaterialProyecto IS NULL THEN 0 ELSE mp.cantidadMaterialProyecto END AS cantidadEntrega,
	ma.calidadMaterial, ma.anchoMaterial, ma.largoMaterial, ma.largoMaterial * 0.3048 LongArea, ma.pesoMaterial,
	(mp.cantidadMaterialProyecto * (ma.largoMaterial * 0.3048) * ma.pesoMaterial) Total
from cmiMaterialesProyecto mp
	INNER JOIN cmiMateriales ma ON mp.idMaterial = ma.idMaterial 
	INNER JOIN cmiUnidadesMedida um ON mp.idUnidadMedida = um.idUnidadMedida
	INNER JOIN cmiInventarios inv ON inv.idMaterial = mp.idMaterial and inv.idAlmacen = mp.idAlmacen
where mp.idEtapa = @idEtapa
and mp.idProyecto = @idProyecto
and mp.idMaterialProyecto = ISNULL(@idMatPro, mp.idMaterialProyecto)
and mp.documentoMaterialProyecto = @idDocumento

END






GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMaterialesProyectoM]    Script Date: 06/05/2016 10:03:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarMaterialesProyectoM]	
	@idProyecto int,
	@idEtapa int,
	@idAlmacen int,
	@idMaterial int,
	@idUnidad int,
	@Revision varchar(10),
	@usuario int,
	@idReq int,
	@idDocumento int
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
DECLARE @Documento int
BEGIN
	
	SET NOCOUNT ON;

	IF @idDocumento = 0
	BEGIN
 		SELECT @Documento = ISNULL(MAX(documentoMaterialProyecto),0) + 1 FROM cmiMaterialesProyecto
	END
	ELSE
	BEGIN
		SET @Documento = @idDocumento
	END

	IF @idMaterial != '' 
	BEGIN
    INSERT INTO cmiMaterialesProyecto
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idProyecto
		   ,revisionProyecto
		   ,idEtapa
		   ,idAlmacen
		   ,idMaterial
		   ,idOrdenProduccion
		   ,cantidadMaterialProyecto
		   ,idUnidadMedida
		   , documentoMaterialProyecto
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuario
           ,@idProyecto 
           ,@Revision
		   ,@idEtapa
		   ,@idAlmacen
		   ,@idMaterial
		   ,@idEtapa
		   ,0
		   ,@idUnidad
		   ,@Documento)
	END

	IF @idReq != 0
	BEGIN
	DECLARE @idMaterialReq int, @CantReq float, @idUnidadReq int, @idOrigenReq int
	 DECLARE cMain CURSOR 
     FOR  
     
	SELECT dr.idMaterial, 0 cantidadSolicitada, dr.idUnidadMedida, dr.idOrigenRequisicion  FROM cmiRequisiciones re
	inner join cmiDetallesRequisicion dr on re.idRequisicion =  dr.idRequisicion
	where re.idRequisicion  =  @idReq
   OPEN cMain

     FETCH NEXT FROM cMain INTO @idMaterialReq, @CantReq, @idUnidadReq, @idOrigenReq
      WHILE @@FETCH_STATUS = 0
          BEGIN 
         INSERT INTO cmiMaterialesProyecto
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idProyecto
		   ,revisionProyecto
		   ,idEtapa
		   ,idAlmacen
		   ,idMaterial
		   ,idOrdenProduccion
		   ,cantidadMaterialProyecto
		   ,idOrigenRequisicion
		   ,idUnidadMedida
		   ,documentoMaterialProyecto
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuario
           ,@idProyecto 
           ,@Revision
		   ,@idEtapa
		   ,@idAlmacen
		   ,@idMaterialReq
		   ,@idEtapa
		   ,@CantReq
		   ,@idOrigenReq
		   ,@idUnidadReq
		   ,@Documento)
                 

       FETCH NEXT FROM cMain 
               INTO @idMaterialReq, @CantReq, @idUnidadReq, @idOrigenReq
         END
      CLOSE cMain
DEALLOCATE cMain

END

                

SELECT @Documento

END



GO
