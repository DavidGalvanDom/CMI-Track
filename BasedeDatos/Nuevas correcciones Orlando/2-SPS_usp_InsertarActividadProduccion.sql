/* ELIMINO SPs OBSOLETOS */
DROP PROCEDURE usp_DarAvance;
DROP PROCEDURE usp_DarRegistroCalidad;
GO

/* CREO NUEVO SP */
CREATE PROCEDURE [dbo].[usp_InsertarActividadProduccion]
	@Tipo CHAR(1),
	@Clase CHAR(1),
	@IdSubmarca INT,
	@IdMarca INT,
	@IdSerie NVARCHAR(2),
	@piezas INT,
	@IdUsuarioFabrico INT,
	@IdEstatus INT,
	@Observaciones VARCHAR(MAX),
	@Longitud BIT,
	@Barrenacion BIT,
	@Placa BIT,
	@Soldadura BIT,
	@Pintura BIT,
	@IdUsuarioCreacion INT
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 30/Abril/16
-- Descripcion: Da un Registro de Actividad
-- Parametros de salida:
-- Parametros de entrada: 
******************************************

EXEC usp_InsertarActividadProduccion 'P', 'M', 0, 1, '00', 1, 1, 0, NULL, 0, 0, 0, 0, 0, 4

*/
BEGIN
	
	SET NOCOUNT ON;

	-- Declaracion de variables
	DECLARE @idProcesoActual INT = 0
	DECLARE @secuencia INT = 0
	DECLARE @idTipoProceso INT = 0
	DECLARE @idProcesoSiguiente INT = 0
	DECLARE @evalValores INT = 0

	IF @Clase = 'M'
	BEGIN
		----------------------
		--		MARCAS		--
		----------------------
		SET @IdSubmarca = NULL
		SET @IdSerie = RIGHT(REPLICATE('0',2) + LTRIM(RTRIM(@IdSerie)), 2)

		--Obtengo el id del Proceso Actual
		SELECT @idProcesoActual = ISNULL(S.idProcesoActual,0)
		FROM cmiSeries S
		WHERE S.idMarca = @IdMarca AND S.idSerie = @IdSerie

		IF @idProcesoActual = 0
		BEGIN
			-----------------------------------------------
			-- La marca NO ha tenido avances previamente --
			-----------------------------------------------
			-- Obtengo el menor numero de secuencia 
			--  para los Procesos de Marca
			SELECT @secuencia = MIN(RF.secuenciaRutaFabricacion)
			FROM cmiMarcas M
			INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
			INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
			INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
			INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
			INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
			INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
			INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
			WHERE PR.claseAvance = @Clase

			-- Obtengo el idProceso y idTipoProceso para esa secuencia
			SELECT TOP 1 @idTipoProceso = PR.idTipoProceso, @idProcesoActual = PR.idProceso
			FROM cmiMarcas M
			INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
			INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
			INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
			INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
			INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
			INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
			INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
			WHERE PR.claseAvance = @Clase
				AND RF.secuenciaRutaFabricacion = @secuencia

			-- Obtengo el Proceso Siguiente
			SELECT TOP 1 @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiPlanosMontaje PM ON PM.idEtapa = E.idEtapa
			INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoMontaje = PM.idPlanoMontaje
			INNER JOIN cmiMarcas M ON M.idPlanoDespiece = PD.idPlanoDespiece
			WHERE M.idMarca = @IdMarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1

		END
		ELSE
		BEGIN
			-----------------------------------------------
			-- La marca SI ha tenido avances previamente --
			-----------------------------------------------
			-- Obtengo secuencia y idTipoProceso
			SELECT TOP 1 @secuencia = Rf2.secuenciaRutaFabricacion, @idTipoProceso = PR2.idTipoProceso
			FROM cmiRutasFabricacion RF2
			INNER JOIN cmiCategorias C2 ON C2.idCategoria = RF2.idCategoria
			INNER JOIN cmiProyectos P2 ON P2.idCategoria = C2.idCategoria
			INNER JOIN cmiEtapas E2 ON E2.idProyecto = P2.idProyecto
			INNER JOIN cmiPlanosMontaje PM2 ON PM2.idEtapa = E2.idEtapa
			INNER JOIN cmiPlanosDespiece PD2 ON PD2.idPlanoMontaje = PM2.idPlanoMontaje
			INNER JOIN cmiMarcas M2 ON M2.idPlanoDespiece = PD2.idPlanoDespiece
			INNER JOIN cmiProcesos PR2 ON PR2.idProceso = RF2.idProceso
			WHERE M2.idMarca = @IdMarca
				AND RF2.idProceso = @idProcesoActual

			-- Obtengo el Proceso siguiente
			SELECT TOP 1 @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiPlanosMontaje PM ON PM.idEtapa = E.idEtapa
			INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoMontaje = PM.idPlanoMontaje
			INNER JOIN cmiMarcas M ON M.idPlanoDespiece = PD.idPlanoDespiece
			WHERE M.idMarca = @IdMarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1
		END
	END
	ELSE
	BEGIN
		----------------------
		--	  SUBMARCAS		--
		----------------------
		
		SET @IdMarca = NULL
		SET @IdSerie =NULL

		--Obtengo el id del Proceso Actual
		SELECT @idProcesoActual = ISNULL(SM.idProcesoActual,0)
		FROM cmiSubMarcas SM
		WHERE SM.idSubMarca = @IdSubmarca

		IF @idProcesoActual = 0
		BEGIN
			--------------------------------------------------
			-- La submarca NO ha tenido avances previamente --
			--------------------------------------------------
			-- Obtengo el menor numero de secuencia 
			--  para los Procesos de SubMarca
			SELECT @secuencia = MIN(RF.secuenciaRutaFabricacion)
			FROM cmiSubMarcas SM
			INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
			INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
			INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
			INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
			INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
			WHERE PR.claseAvance = @Clase

			-- Obtengo el idProceso y idTipoProceso para esa secuencia
			SELECT TOP 1 @idTipoProceso = PR.idTipoProceso, @idProcesoActual = PR.idProceso
			FROM cmiSubMarcas SM
			INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
			INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
			INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
			INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
			INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
			WHERE PR.claseAvance = @Clase
				AND RF.secuenciaRutaFabricacion = @secuencia
				AND PR.nombreProceso = (SELECT CASE WHEN SM1.claseSubMarca = 'P' THEN 'PANTOGRAFO'
													ELSE 'CORTE' END
										FROM cmiSubMarcas SM1
										WHERE SM1.idSubMarca = @IdSubmarca)

			-- Obtengo el Proceso siguiente
			SELECT TOP 1 @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiSubMarcas SM ON SM.idOrdenProduccion = E.idEtapa
			WHERE SM.idSubMarca = @IdSubmarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1

		END
		ELSE
		BEGIN
			--------------------------------------------------
			-- La submarca SI ha tenido avances previamente --
			--------------------------------------------------
			-- Obtengo secuencia y idTipoProceso
			SELECT TOP 1 @secuencia = Rf2.secuenciaRutaFabricacion, @idTipoProceso = PR2.idTipoProceso
			FROM cmiRutasFabricacion RF2
			INNER JOIN cmiCategorias C2 ON C2.idCategoria = RF2.idCategoria
			INNER JOIN cmiProyectos P2 ON P2.idCategoria = C2.idCategoria
			INNER JOIN cmiEtapas E2 ON E2.idProyecto = P2.idProyecto
			INNER JOIN cmiSubMarcas SM2 ON SM2.idOrdenProduccion = E2.idEtapa
			INNER JOIN cmiProcesos PR2 ON PR2.idProceso = RF2.idProceso
			WHERE SM2.idSubMarca = @IdSubmarca 
				AND RF2.idProceso = @idProcesoActual

			-- Obtengo el Proceso siguiente
			SELECT TOP 1 @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiSubMarcas SM ON SM.idOrdenProduccion = E.idEtapa
			WHERE SM.idSubMarca = @IdSubmarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1
		END
	END

	-- Evaluo si tengo datos para todo el proceso
	IF @idProcesoSiguiente > 0 AND @idProcesoActual > 0 AND @idTipoProceso > 0
	BEGIN
		IF @Tipo = 'P' -- Procesos Productivos no llevan registros de calidad
		BEGIN
			SET @Barrenacion = NULL
			SET @IdEstatus = NULL
			SET @Longitud = NULL
			SET @Observaciones = NULL
			SET @Pintura = NULL
			SET @Placa = NULL
			SET @Soldadura = NULL
		END

		-- Solo Actualizo Serie, ya que submarca no avanzan de proceso, solo se agrega historico
		IF @Clase = 'M'
		BEGIN
			IF @IdEstatus IS NULL -- PROCESO PRODUCTIVO
				UPDATE cmiSeries SET idProcesoActual = @idProcesoSiguiente
							   WHERE idMarca = @IdMarca 
								 AND idSerie = @IdSerie
			IF @IdEstatus = 20 -- LIBERADO
				UPDATE cmiSeries SET idProcesoActual = @idProcesoSiguiente,
									 idEstatusCalidad = @IdEstatus
							   WHERE idMarca = @IdMarca 
								 AND idSerie = @IdSerie
			IF @IdEstatus = 21 -- RECHAZADO
				UPDATE cmiSeries SET idEstatusCalidad = @IdEstatus
							   WHERE idMarca = @IdMarca 
								 AND idSerie = @IdSerie
		END
		-- Guardo Actividad
		INSERT INTO cmiActividadesProduccion (tipoActividad,		claseActividad,			idSubMarca,				
											  idMarca,				idSerie,				piezasActividad,
											  fechaActividad,		idTipoProceso,			idProceso,				
											  idUsuarioFabrico,		idEstatus_Calidad,		observacionesCalidad,	
											  longitudCalidad,		barrenacionCalidad,		placaCalidad,
											  soldaduraCalidad,		pinturaCalidad,			usuarioCreacion)
				VALUES						 (@Tipo,				@Clase,					@IdSubmarca,
											  @IdMarca,				@IdSerie,				@piezas,
											  GETDATE(),			@idTipoProceso,			@idProcesoActual,
											  @IdUsuarioFabrico,	@IdEstatus,				@Observaciones,
											  @Longitud,			@Barrenacion,			@Placa,
											  @Soldadura,			@Pintura,				@IdUsuarioCreacion)
		SELECT '0';
	END
	ELSE
	BEGIN
		SELECT '1';
	END
END
GO
