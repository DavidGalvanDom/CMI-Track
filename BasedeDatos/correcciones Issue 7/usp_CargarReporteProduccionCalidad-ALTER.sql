USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionCalidad]    Script Date: 20/04/2016 05:10:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_CargarReporteProduccionCalidad]
	@IdProyecto int,
	@FechaInicio varchar(10),
	@FechaFin varchar(10)
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

	SELECT RC.idRegistroCalidad
		   ,CONVERT(VARCHAR(10),RC.fechaRegistroCalidad,103) AS fechaRegistroCalidad
		   ,P.nombreProyecto
		   ,E.nombreEtapa
		   ,M.nombreMarca
		   ,S.idSerie
		   ,M.pesoMarca
		   ,PR.nombreProceso
		   ,CONCAT(RTRIM(U.nombreUsuario),' ',RTRIM(U.apePaternoUsuario),' ',RTRIM(U.apeMaternoUsuario)) AS nombreUsuario
		   ,CASE RC.longitudRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS longitudRegistroCalidad
		   ,CASE RC.barrenacionRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS barrenacionRegistroCalidad
		   ,CASE RC.placaRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS placaRegistroCalidad
		   ,CASE RC.soldaduraRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS soldaduraRegistroCalidad
		   ,CASE RC.pinturaRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS pinturaRegistroCalidad
		   ,'' AS P
		   ,'' AS S
		   ,'' AS [PI]
		   ,ES.nombreEstatus
		   ,RC.observacionesRegistroCalidad
	FROM cmiRegistrosCalidad RC
	INNER JOIN cmiSeries S ON RC.idMarca_SubMarca = S.idMarca AND S.idSerie = RC.idSerie
	INNER JOIN cmiMarcas M ON M.idMarca = S.idMarca
	INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	INNER JOIN cmiRutasFabricacion RF ON RF.idRutaFabricacion = RC.idRutaFabricacion
	INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
	INNER JOIN cmiUsuarios U ON U.idUsuario = RC.idUsuario
	INNER JOIN cmiEstatus ES ON ES.idEstatus = RC.idEstatus
	WHERE P.idProyecto = @IdProyecto
	AND RC.fechaRegistroCalidad >= convert(datetime, @FechaInicio, 103) 
	AND RC.fechaRegistroCalidad <= convert(datetime, @FechaFin, 103)
	AND RC.claseRegistro = 'M'
	
	UNION

	SELECT RC.idRegistroCalidad
		   ,CONVERT(VARCHAR(10),RC.fechaRegistroCalidad,103) AS fechaRegistroCalidad
		   ,P.nombreProyecto
		   ,E.nombreEtapa
		   ,M.nombreMarca
		   ,SM.codigoSubMarca
		   ,SM.pesoSubMarca
		   ,PR.nombreProceso
		   ,CONCAT(RTRIM(U.nombreUsuario),' ',RTRIM(U.apePaternoUsuario),' ',RTRIM(U.apeMaternoUsuario)) AS nombreUsuario
		   ,CASE RC.longitudRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS longitudRegistroCalidad
		   ,CASE RC.barrenacionRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS barrenacionRegistroCalidad
		   ,CASE RC.placaRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS placaRegistroCalidad
		   ,CASE RC.soldaduraRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS soldaduraRegistroCalidad
		   ,CASE RC.pinturaRegistroCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS pinturaRegistroCalidad
		   ,'' AS P
		   ,'' AS S
		   ,'' AS [PI]
		   ,ES.nombreEstatus
		   ,RC.observacionesRegistroCalidad
	FROM cmiRegistrosCalidad RC
	INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = RC.idMarca_SubMarca
	INNER JOIN cmiMarcas M ON M.idMarca = SM.idMarca
	INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	INNER JOIN cmiRutasFabricacion RF ON RF.idRutaFabricacion = RC.idRutaFabricacion
	INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
	INNER JOIN cmiUsuarios U ON U.idUsuario = RC.idUsuario
	INNER JOIN cmiEstatus ES ON ES.idEstatus = RC.idEstatus
	WHERE P.idProyecto = @IdProyecto
	AND RC.fechaRegistroCalidad >= convert(datetime, @FechaInicio, 103) 
	AND RC.fechaRegistroCalidad <= convert(datetime, @FechaFin, 103)
	AND RC.claseRegistro = 'S'	
END




