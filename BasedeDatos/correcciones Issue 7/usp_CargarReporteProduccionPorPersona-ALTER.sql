USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionPorPersona]    Script Date: 20/04/2016 05:17:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_CargarReporteProduccionPorPersona]
	@IdProyecto int,
	@FechaInicio varchar(10),
	@FechaFin varchar(10)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 04/Abril/16
-- Descripcion: Reporte Produccion Por Persona
-- Parametros de salida:
-- Parametros de entrada:
******************************************

EXEC usp_CargarReporteProduccionPorPersona 1, '01/04/2016', '30/04/2016'

*/
BEGIN
	
	SET NOCOUNT ON;

	WITH cte (id, fecha, idUsuario, nombreUsuario, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, peso) 
	AS (
		-- MARCAS AVANCE
		SELECT	CONCAT('MA',HA.idHistoricoAvance) AS id,
				HA.fechaAvance AS fecha,
				HA.idUsuario,
				CONCAT(U.nombreUsuario,' ',U.apePaternoUsuario,' ',U.apeMaternoUsuario) AS nombreUsuario,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'MARCA' AS clase,
				M.nombreMarca AS nombreElemento,
				HA.idSerie,
				PR.nombreProceso,
				M.pesoMarca AS peso
		FROM cmiHistoricoAvances HA
		INNER JOIN cmiUsuarios U ON U.idUsuario = HA.idUsuario
		INNER JOIN cmiMarcas M ON M.idMarca = HA.idMarca_Submarca
		INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
		INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
		INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiRutasFabricacion RF ON RF.idRutaFabricacion = HA.idRutaFabricacionInicio
		INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
		WHERE HA.claseAvance = 'M' 
	
		UNION ALL

		-- SUBMARCAS AVANCE
		SELECT	CONCAT('SA',HA.idHistoricoAvance) AS id,
				HA.fechaAvance AS fecha,
				HA.idUsuario,
				CONCAT(U.nombreUsuario,' ',U.apePaternoUsuario,' ',U.apeMaternoUsuario) AS nombreUsuario,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'SUBMARCA' AS clase,
				SM.codigoSubMarca AS nombreElemento,
				HA.idSerie,
				PR.nombreProceso,
				SM.pesoSubMarca AS peso
		FROM cmiHistoricoAvances HA
		INNER JOIN cmiUsuarios U ON U.idUsuario = HA.idUsuario
		INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = HA.idMarca_Submarca
		INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiRutasFabricacion RF ON RF.idRutaFabricacion = HA.idRutaFabricacionInicio
		INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
		WHERE HA.claseAvance = 'S' 

		UNION ALL

		-- MARCAS CALIDAD
		SELECT	CONCAT('MC',RC.idRegistroCalidad) AS id,
				RC.fechaRegistroCalidad AS fecha,
				RC.idUsuario,
				CONCAT(U.nombreUsuario,' ',U.apePaternoUsuario,' ',U.apeMaternoUsuario) AS nombreUsuario,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'MARCA' AS clase,
				M.nombreMarca AS nombreElemento,
				RC.idSerie,
				PR.nombreProceso,
				M.pesoMarca AS peso
		FROM cmiRegistrosCalidad RC
		INNER JOIN cmiUsuarios U ON U.idUsuario = RC.idUsuario
		INNER JOIN cmiMarcas M ON M.idMarca = RC.idMarca_Submarca
		INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
		INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
		INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiRutasFabricacion RF ON RF.idRutaFabricacion = RC.idRutaFabricacion
		INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
		WHERE RC.claseRegistro = 'M' 
	
		UNION ALL

		-- SUBMARCAS REGISTRO CALIDAD
		SELECT	CONCAT('SC',RC.idRegistroCalidad) AS id,
				RC.fechaRegistroCalidad AS fecha,
				RC.idUsuario,
				CONCAT(U.nombreUsuario,' ',U.apePaternoUsuario,' ',U.apeMaternoUsuario) AS nombreUsuario,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'SUBMARCA' AS clase,
				SM.codigoSubMarca AS nombreElemento,
				RC.idSerie,
				PR.nombreProceso,
				SM.pesoSubMarca AS peso
		FROM cmiRegistrosCalidad RC
		INNER JOIN cmiUsuarios U ON U.idUsuario = RC.idUsuario
		INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = RC.idMarca_Submarca
		INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiRutasFabricacion RF ON RF.idRutaFabricacion = RC.idRutaFabricacion
		INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
		WHERE RC.claseRegistro = 'S' 
	)
	SELECT id, convert(varchar(10), fecha, 103) AS fecha, idUsuario, nombreUsuario, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, peso
	FROM cte
	WHERE idProyecto = @IdProyecto
		AND fecha >= convert(datetime, @FechaInicio, 103)
		AND fecha <= convert(datetime, @FechaFin, 103)
	ORDER BY idUsuario, fecha
		
END





