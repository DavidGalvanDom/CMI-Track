USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_DarRegistroCalidad]    Script Date: 20/04/2016 04:49:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_DarRegistroCalidad]
	@ClaseRegistro CHAR(1),
	@IdMarca_Submarca INT,
	@IdSerie NVARCHAR(2),
	@IdUsuario INT,
	@Observaciones VARCHAR(MAX),
	@IdEstatus INT,
	@Longitud BIT,
	@Barrenacion BIT,
	@Placa BIT,
	@Soldadura BIT,
	@Pintura BIT
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Abril/16
-- Descripcion: Da un Registro de Calidad
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	-- Declaracion de variables
	DECLARE @idProcesoActual INT = 0
	DECLARE @secuencia INT = 0
	DECLARE @idRutaFabricacionInicio INT = 0
	DECLARE @idRutaFabricacionFin INT = 0
	DECLARE @idProcesoSiguiente INT = 0
	DECLARE @evalValores INT = 0

	SET @IdSerie = RIGHT('00' + LTRIM(RTRIM(@IdSerie)), 2)

	IF @ClaseRegistro = 'M'
	BEGIN
		----------------------
		--		MARCAS		--
		----------------------

		--Obtengo el id del Proceso Actual
		SELECT @idProcesoActual = ISNULL(S.idProcesoActual,0)
		FROM cmiSeries S
		WHERE S.idMarca = @IdMarca_Submarca AND S.idSerie = @IdSerie

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
			WHERE PR.claseAvance = @ClaseRegistro

			-- Obtengo el id de la ruta de fabricacion para esa secuencia
			SELECT TOP 1 @idRutaFabricacionInicio = RF.idRutaFabricacion
			FROM cmiMarcas M
			INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
			INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
			INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
			INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
			INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
			INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
			INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
			WHERE PR.claseAvance = @ClaseRegistro
				AND RF.secuenciaRutaFabricacion = @secuencia

			-- Obtengo el Proceso y Ruta de Fabricacion siguiente
			SELECT TOP 1 @idRutaFabricacionFin = RF.idRutaFabricacion, @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiPlanosMontaje PM ON PM.idEtapa = E.idEtapa
			INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoMontaje = PM.idPlanoMontaje
			INNER JOIN cmiMarcas M ON M.idPlanoDespiece = PD.idPlanoDespiece
			WHERE M.idMarca = @IdMarca_Submarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1

		END
		ELSE
		BEGIN
			-----------------------------------------------
			-- La marca SI ha tenido avances previamente --
			-----------------------------------------------
			-- Obtengo secuencia y Ruta de Fabricacion Inicio
			SELECT TOP 1 @secuencia = Rf2.secuenciaRutaFabricacion, @idRutaFabricacionInicio = RF2.idRutaFabricacion
			FROM cmiRutasFabricacion RF2
			INNER JOIN cmiCategorias C2 ON C2.idCategoria = RF2.idCategoria
			INNER JOIN cmiProyectos P2 ON P2.idCategoria = C2.idCategoria
			INNER JOIN cmiEtapas E2 ON E2.idProyecto = P2.idProyecto
			INNER JOIN cmiPlanosMontaje PM2 ON PM2.idEtapa = E2.idEtapa
			INNER JOIN cmiPlanosDespiece PD2 ON PD2.idPlanoMontaje = PM2.idPlanoMontaje
			INNER JOIN cmiMarcas M2 ON M2.idPlanoDespiece = PD2.idPlanoDespiece
			WHERE M2.idMarca = @IdMarca_Submarca 
				AND RF2.idProceso = @idProcesoActual

			-- Obtengo el Proceso y Ruta de Fabricacion siguiente
			SELECT TOP 1 @idRutaFabricacionFin = RF.idRutaFabricacion, @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiPlanosMontaje PM ON PM.idEtapa = E.idEtapa
			INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoMontaje = PM.idPlanoMontaje
			INNER JOIN cmiMarcas M ON M.idPlanoDespiece = PD.idPlanoDespiece
			WHERE M.idMarca = @IdMarca_Submarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1
		END

		-- Evaluo si tengo datos para todo el proceso
		IF @idProcesoSiguiente > 0 AND @idRutaFabricacionInicio > 0 AND @idRutaFabricacionFin > 0
			SET @evalValores = 1;

		IF @evalValores > 0
		BEGIN
			-- Me fijo si es LIBERACION o RECHAZO
			IF @IdEstatus = 20 
			BEGIN -- LIBERADO
				-- Actualizo Serie en Proceso y Estatus
				UPDATE cmiSeries 
				SET idProcesoActual = @idProcesoSiguiente,
					idEstatusCalidad = @IdEstatus
				WHERE idMarca = @IdMarca_Submarca AND idSerie = @IdSerie
			END
			ELSE
			BEGIN -- RECHAZADO
				-- Actualizo Serie en solo Estatus
				UPDATE cmiSeries 
				SET idEstatusCalidad = @IdEstatus
				WHERE idMarca = @IdMarca_Submarca AND idSerie = @IdSerie
			END

				-- Guardo Historico
			INSERT INTO cmiRegistrosCalidad (claseRegistro,					idMarca_Submarca,			idSerie, 
											fechaRegistroCalidad,			idUsuario,					idRutaFabricacion, 
											observacionesRegistroCalidad,	idEstatus,					longitudRegistroCalidad,
											barrenacionRegistroCalidad,		placaRegistroCalidad,		soldaduraRegistroCalidad,
											pinturaRegistroCalidad)
					VALUES			(@ClaseRegistro,			@IdMarca_Submarca,			@IdSerie,
									 GETDATE(),					@IdUsuario,					@idRutaFabricacionInicio,
									 @Observaciones,			@IdEstatus,					@Longitud,
									 @Barrenacion,				@Placa,						@Soldadura,
									 @Pintura)
			SELECT '0:::';
		END
		ELSE
		BEGIN
			SELECT '1:::No hay datos de la Ruta de Fabricacion para el Proceso Siguiente';
		END
	END
	ELSE
	BEGIN
		----------------------
		--	  SUBMARCAS		--
		----------------------

		--Obtengo el id del Proceso Actual
		SELECT @idProcesoActual = ISNULL(SM.idProcesoActual,0)
		FROM cmiSubMarcas SM
		WHERE SM.idSubMarca = @IdMarca_Submarca

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
			WHERE PR.claseAvance = @ClaseRegistro

			-- Obtengo el id de la ruta de fabricacion para esa secuencia
			SELECT TOP 1 @idRutaFabricacionInicio = RF.idRutaFabricacion
			FROM cmiSubMarcas SM
			INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
			INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
			INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
			INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
			INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
			WHERE PR.claseAvance = @ClaseRegistro
				AND RF.secuenciaRutaFabricacion = @secuencia

			-- Obtengo el Proceso y Ruta de Fabricacion siguiente
			SELECT TOP 1 @idRutaFabricacionFin = RF.idRutaFabricacion, @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiSubMarcas SM ON SM.idOrdenProduccion = E.idEtapa
			WHERE SM.idSubMarca = @IdMarca_Submarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1

		END
		ELSE
		BEGIN
			--------------------------------------------------
			-- La submarca SI ha tenido avances previamente --
			--------------------------------------------------
			-- Obtengo secuencia y Ruta de Fabricacion Inicio
			SELECT TOP 1 @secuencia = Rf2.secuenciaRutaFabricacion, @idRutaFabricacionInicio = RF2.idRutaFabricacion
			FROM cmiRutasFabricacion RF2
			INNER JOIN cmiCategorias C2 ON C2.idCategoria = RF2.idCategoria
			INNER JOIN cmiProyectos P2 ON P2.idCategoria = C2.idCategoria
			INNER JOIN cmiEtapas E2 ON E2.idProyecto = P2.idProyecto
			INNER JOIN cmiSubMarcas SM2 ON SM2.idOrdenProduccion = E2.idEtapa
			WHERE SM2.idSubMarca = @IdMarca_Submarca 
				AND RF2.idProceso = @idProcesoActual

			-- Obtengo el Proceso y Ruta de Fabricacion siguiente
			SELECT TOP 1 @idRutaFabricacionFin = RF.idRutaFabricacion, @idProcesoSiguiente = RF.idProceso
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiCategorias C ON C.idCategoria = RF.idCategoria
			INNER JOIN cmiProyectos P ON P.idCategoria = C.idCategoria
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiSubMarcas SM ON SM.idOrdenProduccion = E.idEtapa
			WHERE SM.idSubMarca = @IdMarca_Submarca
				AND RF.secuenciaRutaFabricacion = @secuencia + 1
		END

		-- Evaluo si tengo datos para todo el proceso
		IF @idProcesoSiguiente > 0 AND @idRutaFabricacionInicio > 0 AND @idRutaFabricacionFin > 0
			SET @evalValores = 1;

		IF @evalValores > 0
		BEGIN
			-- NO Actualizo SubMarca, ya que como es por piezas se deja como esta en su lugar
			-- UPDATE cmiSeries 
			-- SET idProcesoActual = @idProcesoSiguiente
			-- WHERE idMarca = @IdMarca_Submarca AND idSerie = @IdSerie

			-- Guardo Historico
			INSERT INTO cmiRegistrosCalidad (claseRegistro,					idMarca_Submarca,			idSerie, 
											fechaRegistroCalidad,			idUsuario,					idRutaFabricacion, 
											observacionesRegistroCalidad,	idEstatus,					longitudRegistroCalidad,
											barrenacionRegistroCalidad)
					VALUES			(@ClaseRegistro,			@IdMarca_Submarca,			@IdSerie,
									 GETDATE(),					@IdUsuario,					@idRutaFabricacionInicio,
									 @Observaciones,			@IdEstatus,					@Longitud,
									 @Barrenacion)
			SELECT '0:::';
		END
		ELSE
		BEGIN
			SELECT '1:::No hay datos de la Ruta de Fabricacion para el Proceso Siguiente';
		END
	END
END









