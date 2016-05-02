
ALTER PROCEDURE [dbo].[usp_CargarReporteProduccionCalidad]
	@IdProyecto INT,
	@FechaInicio VARCHAR(10),
	@FechaFin VARCHAR(10)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 04/Abril/16
-- Descripcion: Reporte Calidad
-- Parametros de salida:
-- Parametros de entrada:
******************************************

EXEC usp_CargarReporteProduccionCalidad 1, '01/04/2016', '30/04/2016'

*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @dFechaInicio DATETIME = CONVERT(DATETIME, @FechaInicio, 103);
	DECLARE @dFechaFin DATETIME = CONVERT(DATETIME, @FechaFin, 103) + ' ' + CONVERT(VARCHAR(8),'23:59:59',14)

	SELECT AP.idActividad AS idRegistroCalidad
		   ,CONVERT(VARCHAR(10),AP.fechaActividad,103) AS fechaRegistroCalidad
		   ,P.nombreProyecto
		   ,E.nombreEtapa
		   ,M.nombreMarca
		   ,S.idSerie
		   ,M.pesoMarca
		   ,PR.nombreProceso
		   ,CONCAT(RTRIM(U.nombreUsuario),' ',RTRIM(U.apePaternoUsuario),' ',RTRIM(U.apeMaternoUsuario)) AS nombreUsuario
		   ,CASE AP.longitudCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS longitudRegistroCalidad
		   ,CASE AP.barrenacionCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS barrenacionRegistroCalidad
		   ,CASE AP.placaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS placaRegistroCalidad
		   ,CASE AP.soldaduraCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS soldaduraRegistroCalidad
		   ,CASE AP.pinturaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS pinturaRegistroCalidad
		   ,ES.nombreEstatus
		   ,ISNULL(AP.observacionesCalidad,'') AS observacionesRegistroCalidad
	FROM cmiActividadesProduccion AP
	INNER JOIN cmiSeries S ON AP.idMarca = S.idMarca AND S.idSerie = AP.idSerie
	INNER JOIN cmiMarcas M ON M.idMarca = S.idMarca
	INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
	INNER JOIN cmiUsuarios U ON U.idUsuario = AP.idUsuarioFabrico
	INNER JOIN cmiEstatus ES ON ES.idEstatus = AP.idEstatus_Calidad
	WHERE P.idProyecto = @IdProyecto
	AND AP.fechaActividad >= @dFechaInicio
	AND AP.fechaActividad <= @dFechaFin
	AND AP.claseActividad = 'M' AND AP.tipoActividad = 'C'
	
	UNION

	SELECT AP.idActividad AS idRegistroCalidad
		   ,CONVERT(VARCHAR(10),AP.fechaActividad,103) AS fechaRegistroCalidad
		   ,P.nombreProyecto
		   ,E.nombreEtapa
		   ,M.nombreMarca
		   ,SM.codigoSubMarca
		   ,SM.pesoSubMarca
		   ,PR.nombreProceso
		   ,CONCAT(RTRIM(U.nombreUsuario),' ',RTRIM(U.apePaternoUsuario),' ',RTRIM(U.apeMaternoUsuario)) AS nombreUsuario
		   ,CASE AP.longitudCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS longitudRegistroCalidad
		   ,CASE AP.barrenacionCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS barrenacionRegistroCalidad
		   ,CASE AP.placaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS placaRegistroCalidad
		   ,CASE AP.soldaduraCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS soldaduraRegistroCalidad
		   ,CASE AP.pinturaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS pinturaRegistroCalidad
		   ,ES.nombreEstatus
		   ,AP.observacionesCalidad
	FROM cmiActividadesProduccion AP
	INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = AP.idSubmarca
	INNER JOIN cmiMarcas M ON M.idMarca = SM.idMarca
	INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
	INNER JOIN cmiUsuarios U ON U.idUsuario = AP.idUsuarioFabrico
	INNER JOIN cmiEstatus ES ON ES.idEstatus = AP.idEstatus_Calidad
	WHERE P.idProyecto = @IdProyecto
	AND AP.fechaActividad >= @dFechaInicio
	AND AP.fechaActividad <= @dFechaFin
	AND AP.claseActividad = 'S' AND AP.tipoActividad = 'C'
END





