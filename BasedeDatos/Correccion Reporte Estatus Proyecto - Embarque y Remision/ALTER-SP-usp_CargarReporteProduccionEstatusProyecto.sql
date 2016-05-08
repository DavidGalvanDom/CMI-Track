USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionEstatusProyecto]    Script Date: 05/05/2016 09:08:19 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[usp_CargarReporteProduccionEstatusProyecto]
	@IdProyecto int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 14/Abril/16
-- Descripcion: Reporte Produccion ESTATUS PROYECTO
-- Parametros de salida:
-- Parametros de entrada:
******************************************

EXEC usp_CargarReporteProduccionEstatusProyecto 1

*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @nombreCategoria NVARCHAR(50);

	SELECT @nombreCategoria = C.nombreCategoria
	FROM cmiProyectos P
	INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
	WHERE P.idProyecto = @IdProyecto;

	WITH cte(idProceso, proceso, categoria) AS
	(SELECT -1 AS idProceso, 'PLANEACION' AS nombreProceso, @nombreCategoria
	 UNION
	 SELECT PR.idProceso, PR.nombreProceso, C.nombreCategoria
	 FROM cmiRutasFabricacion RF
	 INNER JOIN cmiProyectos P ON P.idCategoria = RF.idCategoria
	 INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
	 INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
	 WHERE P.idProyecto = @IdProyecto
	 UNION SELECT 1000 AS idProceso, 'EMBARQUE' AS nombreProceso, @nombreCategoria
	 UNION SELECT 1001 AS idProceso, 'RECEPCION EMBARQUE' AS nombreProceso, @nombreCategoria
	)
	SELECT  concat(cte.idProceso,'-',ISNULL(tbl.idMarca,0),'-',ISNULL(tbl.idSerie,0)) AS id, 
			cte.proceso,
			CASE ISNULL(tbl.nombreProyecto,'') WHEN '' THEN '' ELSE cte.categoria END AS categoria,
			ISNULL(tbl.nombreProyecto,'') AS proyecto,
			ISNULL(tbl.nombreEtapa,'') AS etapa,
			ISNULL(tbl.nombrePlanoMontaje,'') AS planoMontaje,
			ISNULL(tbl.nombrePlanoDespiece,'') AS planoDespiece,
			ISNULL(tbl.elemento,'') AS marca,
			ISNULL(tbl.idSerie,'') AS serie,
			ISNULL(DATEDIFF(DAY,tbl.fechaUltModificacion,GETDATE()),0) AS diasProceso,
			CASE ISNULL(tbl.idProcesoActual,'') WHEN '' THEN '' ELSE 1 END AS piezas,
			CASE ISNULL(tbl.idProcesoActual,'') WHEN '' THEN '' WHEN 0 THEN 1 ELSE 1 END AS peso
	FROM cte
	LEFT JOIN
	(SELECT CASE 
			WHEN idProcesoActual IS NULL		-- No tiene avance
			THEN -1
			WHEN idProcesoActual IS NOT NULL	-- Tiene avance y
				AND DOE.idOrdenEmbarque IS NULL -- no tiene Orden de Embarque
			THEN idProcesoActual
			WHEN idProcesoActual IS NOT NULL -- Tiene Avance y
				AND DOE.idOrdenEmbarque IS NOT NULL -- tiene Orden Embarque y
				AND RR.idOrdenEmbarque IS NULL -- no tiene Remision
			THEN 1000
			WHEN idProcesoActual IS NOT NULL -- Tiene Avance y
				AND DOE.idOrdenEmbarque IS NOT NULL -- tiene Orden Embarque y
				AND RR.idOrdenEmbarque IS NOT NULL -- tiene Remision THEN 'Other sale items'
			THEN 1001
			ELSE -1
     END AS idProcesoActual, 
			M.idMarca, 
			M.nombreMarca AS elemento, 
			S.idSerie,
			PD.nombrePlanoDespiece, 
			PM.nombrePlanoMontaje, 
			E.nombreEtapa, 
			P.nombreProyecto, 
			M.fechaUltModificacion,
			M.pesoMarca
     FROM cmiSeries S
	 INNER JOIN cmiMarcas M ON M.idMarca = S.idMarca
	 INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	 INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	 INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	 INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	 LEFT JOIN cmiDetalleOrdenEmbarque DOE ON DOE.idMarca = S.idMarca AND DOE.idSerie = S.idSerie
	 LEFT JOIN cmiRegistrarRemision RR ON RR.idMarca = S.idMarca AND RR.idSerie = S.idSerie
	 WHERE P.idProyecto = @IdProyecto
	) tbl ON cte.idProceso = tbl.idProcesoActual
	ORDER BY idProceso, elemento, serie
		
END

