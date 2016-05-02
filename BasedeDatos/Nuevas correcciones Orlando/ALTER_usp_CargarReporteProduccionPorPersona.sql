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

	DECLARE @dFechaInicio DATETIME = CONVERT(DATETIME, @FechaInicio, 103);
	DECLARE @dFechaFin DATETIME = CONVERT(DATETIME, @FechaFin, 103) + ' ' + CONVERT(VARCHAR(8),'23:59:59',14);

	WITH cte (id, fecha, idUsuario, nombreUsuario, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, peso) 
	AS (
		-- MARCAS
		SELECT	AP.idActividad AS id,
				AP.fechaActividad AS fecha,
				AP.idUsuarioFabrico AS idUsuario,
				CONCAT(U.nombreUsuario,' ',U.apePaternoUsuario,' ',U.apeMaternoUsuario) AS nombreUsuario,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'MARCA' AS clase,
				M.nombreMarca AS nombreElemento,
				AP.idSerie,
				PR.nombreProceso,
				M.pesoMarca AS peso
		FROM cmiActividadesProduccion AP
		INNER JOIN cmiUsuarios U ON U.idUsuario = AP.idUsuarioFabrico
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
				AP.idUsuarioFabrico AS idUsuario,
				CONCAT(U.nombreUsuario,' ',U.apePaternoUsuario,' ',U.apeMaternoUsuario) AS nombreUsuario,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'SUBMARCA' AS clase,
				SM.codigoSubMarca AS nombreElemento,
				AP.idSerie,
				PR.nombreProceso,
				SM.pesoSubMarca AS peso
		FROM cmiActividadesProduccion AP
		INNER JOIN cmiUsuarios U ON U.idUsuario = AP.idUsuarioFabrico
		INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = AP.idSubmarca
		INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
		WHERE AP.claseActividad = 'S' 
	)
	SELECT id, convert(varchar(10), fecha, 103) AS fecha, idUsuario, nombreUsuario, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, peso
	FROM cte
	WHERE idProyecto = @IdProyecto
		AND fecha >= @dFechaInicio
		AND fecha <= @dFechaFin
	ORDER BY idUsuario, fecha
		
END






