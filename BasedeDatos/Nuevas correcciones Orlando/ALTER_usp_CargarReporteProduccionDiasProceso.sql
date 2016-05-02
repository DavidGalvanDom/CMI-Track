ALTER PROCEDURE [dbo].[usp_CargarReporteProduccionDiasProceso]
(
	@IdProyecto int,
	@FechaInicio varchar(10),
	@FechaFin varchar(10)
)
AS

/*
		EXEC usp_CargarReporteProduccionDiasProceso 1, '01/04/2016', '05/08/2016'
*/

BEGIN
	SET NOCOUNT ON;
	-- Declaracion de Variables del SP ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	DECLARE @NombreColumna VARCHAR(50)
	DECLARE @SQLDinamico NVARCHAR(MAX) 
	DECLARE @IdRegistro INT
	DECLARE @DiasProceso INT
	
	-- Declaracion de Variables de cursores ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
    DECLARE	@curIdRutaFabricacion INT,
			@curIdProceso INT,
			@curNombreProceso VARCHAR(50),
			@curSecuenciaRutaFabricacion INT,
			@curId	VARCHAR(32),
			@curFecha DATETIME,
			@curIdUsuario INT,
			@curNombreUsuario VARCHAR(150),
			@curIdProyecto INT,
			@curNombreProyecto VARCHAR(50), 
			@curIdEtapa INT,
			@curNombreEtapa VARCHAR(50),
			@curClase VARCHAR(2),
			@curIdMarca_SubMarca INT,
			@curNombreElemento VARCHAR(50),
			@curIdSerie VARCHAR(2),
			@curPeso VARCHAR(50),
			@curFechaUltModificacion DATETIME

	
	-- Asignacion de valores ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	SET @NombreColumna = ''
	SET @IdRegistro = 1
	DECLARE @dFechaInicio DATETIME = CONVERT(DATETIME, @FechaInicio, 103);
	DECLARE @dFechaFin DATETIME = CONVERT(DATETIME, @FechaFin, 103) + ' ' + CONVERT(VARCHAR(8),'23:59:59',14)
	
	-- Tablas temporales ==  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	BEGIN
		IF EXISTS(SELECT object_id FROM tempdb.sys.objects WHERE name LIKE '#ReporteProduccionDiasProceso')
			DROP TABLE #ReporteProduccionDiasProceso;

		CREATE TABLE #ReporteProduccionDiasProceso
					(	IdRegistro INT,			IdProyecto INT,				NombreProyecto VARCHAR(50),
						IdEtapa INT,			NombreEtapa VARCHAR(50),	Clase VARCHAR(32),
						IdMarca_Submarca INT,	NombreElemento VARCHAR(50),	IdSerie CHAR(2),
						DiasProceso INT,		FechaInicio VARCHAR(10),	Peso VARCHAR(50))
	END

	-- Declaracion de cursor ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	BEGIN
		-- CURSOR RUTAS DE FABRICACION
		DECLARE cRutaFabricacion CURSOR LOCAL FAST_FORWARD FOR
			SELECT	RF.idRutaFabricacion,
					RF.idProceso,
					PR.nombreProceso,
					RF.secuenciaRutaFabricacion
			FROM cmiProyectos P
			INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
			INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
			WHERE RF.idEstatus = 1 AND P.idProyecto = @IdProyecto
			ORDER BY secuenciaRutaFabricacion, nombreProceso
	END
	BEGIN
		-- CURSOR HISTORIAL
		DECLARE cHistorial CURSOR LOCAL FAST_FORWARD FOR
			WITH cte (id, fecha, idUsuario, nombreUsuario, idProyecto, nombreProyecto, idEtapa, 
					nombreEtapa, clase, idMarca_SubMarca, nombreElemento, idSerie, nombreProceso, peso, fechaUltModificacion) 
			AS (
				-- MARCAS

				SELECT	AP.idActividad AS id,
						AP.fechaActividad AS fecha,
						AP.idUsuarioFabrico AS idUsuario,
						CONCAT(U.nombreUsuario,' ',U.apePaternoUsuario,' ',U.apeMaternoUsuario) AS nombreUsuario,
						P.idProyecto,
						P.nombreProyecto,
						E.idEtapa,
						E.nombreEtapa,
						AP.claseActividad AS clase,
						AP.idMarca,
						M.nombreMarca AS nombreElemento,
						AP.idSerie,
						PR.nombreProceso,
						M.pesoMarca AS peso,
						M.fechaUltModificacion
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
						E.idEtapa,
						E.nombreEtapa,
						AP.claseActividad AS clase,
						AP.idSubmarca,
						SM.codigoSubMarca AS nombreElemento,
						'00' AS idSerie,
						PR.nombreProceso,
						SM.pesoSubMarca AS peso,
						SM.fechaUltModificacion
				FROM cmiActividadesProduccion AP
				INNER JOIN cmiUsuarios U ON U.idUsuario = AP.idUsuarioFabrico
				INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = AP.idSubmarca
				INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
				INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
				INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
				WHERE AP.claseActividad = 'S' 
			)
			SELECT * FROM cte
			WHERE idProyecto = @IdProyecto
				AND fecha >= CONVERT(DATETIME,@FechaInicio,103)
				AND fecha <= CONVERT(DATETIME,CONCAT(@FechaFin,' 23:59:59'),103)
			ORDER BY fecha
			
	END

	--   ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---
	OPEN cRutaFabricacion
	FETCH NEXT FROM cRutaFabricacion
		  INTO @curIdRutaFabricacion, @curIdProceso, @curNombreProceso, @curSecuenciaRutaFabricacion
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @NombreColumna = @curNombreProceso
		SET @SQLDinamico = 'ALTER TABLE #ReporteProduccionDiasProceso ADD ['+ @NombreColumna +'] VARCHAR(10) NULL'
		EXEC(@SQLDinamico)
		
		FETCH NEXT FROM cRutaFabricacion
		  INTO @curIdRutaFabricacion, @curIdProceso, @curNombreProceso, @curSecuenciaRutaFabricacion
	END
	CLOSE cRutaFabricacion
	DEALLOCATE cRutaFabricacion

	DECLARE @EXISTE INT

	OPEN cHistorial
	FETCH NEXT FROM cHistorial
		INTO @curId, @curFecha, @curIdUsuario, @curNombreUsuario, @curIdProyecto, @curNombreProyecto, @curIdEtapa, @curNombreEtapa, 
			@curClase, @curIdMarca_SubMarca, @curNombreElemento, @curIdSerie, @curNombreProceso, @curPeso, @curFechaUltModificacion
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    /*
			IdRegistro		idProyecto		NombreProyecto		IdEtapa
			NombreEtapa		Clase			IdMarca_Submarca	NombreElemento
			IdSerie			DiasProceso		FechaInicio		{FechasProcesos}
		*/

		SELECT @EXISTE = COUNT(1) FROM #ReporteProduccionDiasProceso 
		WHERE Clase = @curClase AND IdMarca_Submarca = @curIdMarca_SubMarca AND IdSerie = @curIdSerie;

		SELECT @DiasProceso = DATEDIFF(DAY,MIN(AP.fechaActividad),MAX(AP.fechaActividad)) + 1
		FROM cmiActividadesProduccion AP
		WHERE AP.claseActividad = @curClase 
			AND @curIdMarca_SubMarca = CASE WHEN AP.claseActividad = 'S'
											THEN AP.idSubmarca
											ELSE AP.idMarca
										END
			AND AP.idSerie = @curIdSerie
		
		IF (@EXISTE = 0)
		BEGIN
			SELECT @IdRegistro = COUNT(1)+1 FROM #ReporteProduccionDiasProceso

			SET @SQLDinamico = 'INSERT INTO #ReporteProduccionDiasProceso(IdRegistro,IdProyecto,NombreProyecto,IdEtapa,NombreEtapa,Clase,IdMarca_Submarca,NombreElemento,IdSerie,DiasProceso,FechaInicio,['+@curNombreProceso+'],Peso)'
			SET @SQLDinamico = @SQLDinamico + 'VALUES('+CONVERT(VARCHAR(32),@IdRegistro)+','+CONVERT(VARCHAR(32),@curIdProyecto)+','''+@curNombreProyecto+''','+CONVERT(VARCHAR(32),@curIdEtapa)+','''+@curNombreEtapa+''','''+@curClase+''','
			SET @SQLDinamico = @SQLDinamico + CONVERT(VARCHAR(32),@curIdMarca_SubMarca)+','''+@curNombreElemento+''','''+@curIdSerie+''','+CONVERT(VARCHAR(32),@DiasProceso)+','''+CONVERT(VARCHAR(10),@curFechaUltModificacion,103)+''','''+CONVERT(VARCHAR(10),@curFecha,103)+''','+CONVERT(VARCHAR(32),@curPeso)+')'
			EXEC(@SQLDinamico)
		END

		ELSE
		BEGIN
			SET @SQLDinamico = 'UPDATE #ReporteProduccionDiasProceso SET ['+@curNombreProceso+']='''+CONVERT(VARCHAR(10),@curFecha,103)+''''
			SET @SQLDinamico = @SQLDinamico + ' WHERE Clase='''+@curClase+''' AND IdMarca_Submarca='+CONVERT(VARCHAR(32),@curIdMarca_SubMarca)+' AND IdSerie='''+@curIdSerie+''''
			EXEC(@SQLDinamico)
		END

		

		FETCH NEXT FROM cHistorial
		INTO @curId, @curFecha, @curIdUsuario, @curNombreUsuario, @curIdProyecto, @curNombreProyecto, @curIdEtapa, @curNombreEtapa, 
			@curClase, @curIdMarca_SubMarca, @curNombreElemento, @curIdSerie, @curNombreProceso, @curPeso, @curFechaUltModificacion
	END
	CLOSE cHistorial
	DEALLOCATE cHistorial
	---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---
	SELECT *
	  FROM #ReporteProduccionDiasProceso

	--   ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---
END





