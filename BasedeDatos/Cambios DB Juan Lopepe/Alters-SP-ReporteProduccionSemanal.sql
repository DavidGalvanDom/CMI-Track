USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionSemanal]    Script Date: 02/06/2016 11:47:33 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_CargarReporteProduccionSemanal]
	@IdProyecto int,
	@FechaInicio VARCHAR(10),
	@FechaFin VARCHAR(10)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 04/Abril/16
-- Descripcion: Reporte Produccion Por Persona
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @dFechaInicio DATETIME = CONVERT(DATETIME, @FechaInicio, 103);
	DECLARE @dFechaFin DATETIME = CONVERT(DATETIME, @FechaFin, 103) + ' ' + CONVERT(VARCHAR(8),'23:59:59',14);

	WITH cte (id, fecha, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, piezas, peso) 
	AS (
		-- MARCAS
		SELECT	AP.idActividad AS id,
				AP.fechaActividad AS fecha,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'MARCA' AS clase,
				M.nombreMarca AS nombreElemento,
				AP.idSerie,
				PR.nombreProceso,
				AP.piezasActividad,
				M.pesoMarca AS peso
		FROM cmiActividadesProduccion AP
		INNER JOIN cmiMarcas M ON M.idMarca = AP.idMarca
		INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
		INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
		INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
		WHERE AP.claseActividad = 'M' 
	
		UNION ALL

		-- SUBMARCAS
		SELECT	AP.idActividad AS id,
				AP.fechaActividad AS fecha,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'SUBMARCA' AS clase,
				SM.codigoSubMarca AS nombreElemento,
				'' AS idSerie,
				PR.nombreProceso,
				AP.piezasActividad,
				SM.pesoSubMarca AS peso
		FROM cmiActividadesProduccion AP
		INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = AP.idSubmarca
		INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
		WHERE AP.claseActividad = 'S' 
	)
	SELECT id, convert(varchar(10), fecha, 103) AS fecha, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, CASE WHEN piezas = 0 THEN 1 ELSE piezas END AS piezas, peso
	FROM cte
	WHERE idProyecto = @IdProyecto
		AND fecha >= @dFechaInicio
		AND fecha <= @dFechaFin
	ORDER BY fecha
		
END









