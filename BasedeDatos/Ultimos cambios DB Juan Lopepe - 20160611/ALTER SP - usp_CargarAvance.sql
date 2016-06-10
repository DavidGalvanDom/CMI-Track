USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarAvance]    Script Date: 06/10/2016 09:27:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_CargarAvance]
	@idEtapa int,
	@idProceso int,
	@codigoBarras VARCHAR(200)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 25/Marzo/16
-- Descripcion: Se cargan el avance
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	-- Declaracion de variables
	DECLARE @secuenciaInicialMarca INT
	DECLARE @secuenciaProceso INT
	DECLARE @nombreProceso VARCHAR(50)
	DECLARE @clase CHAR(1)

	DECLARE @sCadenaBusqueda VARCHAR(200)

	IF @codigoBarras = ''
		SET @sCadenaBusqueda = '%';
	ELSE
		SET @sCadenaBusqueda = @codigoBarras;

	---------------------------
	SELECT @clase = RTRIM(LTRIM(UPPER(P.claseAvance)))
		  ,@nombreProceso = RTRIM(LTRIM(UPPER(P.nombreProceso)))
	FROM cmiProcesos P
	WHERE P.idProceso = @idProceso;
	
	IF (@clase = 'S') -- SUBMARCA
	BEGIN
		WITH cte1 (id, codigoBarras, codigo, tipo, perfil, clase, estatusCalidad, procesoActual)
		AS (
			SELECT  CONCAT(@clase,'-',SM.idSubMarca,'-00')		AS id
				   ,CONCAT(@clase,'-',SM.idSubMarca,'-00')		AS codigoBarras
				   ,codigoSubMarca								AS codigo
				   ,'SUBMARCA'									AS tipo
				   ,SM.perfilSubMarca							AS perfil
				   ,SM.claseSubMarca							AS clase
				   ,ISNULL(E.nombreEstatus,'LIBERADO')			AS estatusCalidad
				   ,@nombreProceso								AS procesoActual
			FROM cmiSubMarcas SM
			LEFT JOIN cmiEstatus E ON E.idEstatus = SM.idEstatusCalidad
			WHERE SM.idOrdenProduccion = @idEtapa
				AND ( SM.idProcesoActual IN (-1,0,@idProceso) OR SM.idProcesoActual IS NULL)
				AND SM.claseSubMarca = LEFT(@nombreProceso,1)
				AND SM.idEstatus = 1
		)
		SELECT *
		FROM cte1
		WHERE codigoBarras LIKE @sCadenaBusqueda
		ORDER BY id
	END 
	ELSE -- MARCA-SERIE
	BEGIN
		-- Obtengo la menor secuencia de los procesos de tipo Marca
		SELECT @secuenciaInicialMarca = MIN(RF.secuenciaRutaFabricacion)
		FROM cmiRutasFabricacion RF
		INNER JOIN cmiProcesos P ON P.idProceso = RF.idProceso
		INNER JOIN cmiProyectos PR ON PR.idCategoria = RF.idCategoria
		INNER JOIN cmiEtapas E ON E.idProyecto = PR.idProyecto
		WHERE E.idEtapa = @idEtapa 
			AND P.claseAvance = 'M'

		-- Obtengo el numero de secuencia del Proceso Actual
		SELECT TOP 1 @secuenciaProceso = RF.secuenciaRutaFabricacion
		FROM cmiRutasFabricacion RF
		INNER JOIN cmiProyectos PR ON RF.idCategoria = PR.idCategoria
		INNER JOIN cmiEtapas E ON E.idProyecto = PR.idProyecto
		WHERE RF.idProceso = @IdProceso AND E.idEtapa = @idEtapa

		IF @secuenciaInicialMarca = @secuenciaProceso
		BEGIN
			WITH cte2 (id, codigoBarras, codigo, tipo, perfil, clase, estatusCalidad, procesoActual)
			AS (
				SELECT  CONCAT(@clase,'-',M.idMarca,'-',S.idSerie)	AS id
					   ,CONCAT(@clase,'-',M.idMarca,'-',S.idSerie)	AS codigoBarras
					   ,codigoMarca									AS codigo
					   ,'MARCA'										AS tipo
					   ,'N/A'										AS perfil
					   ,'N/A'										AS clase
					   ,ISNULL(E.nombreEstatus,'LIBERADO')			AS estatusCalidad
					   ,@nombreProceso								AS procesoActual
				FROM cmiMarcas M
				INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
				INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
				INNER JOIN cmiEtapas ET ON ET.idEtapa = PM.idEtapa
				INNER JOIN cmiSeries S ON M.idMarca = S.idMarca
				LEFT JOIN cmiEstatus E ON E.idEstatus = S.idEstatusCalidad
				WHERE ET.idEtapa = @idEtapa 
					AND ( S.idProcesoActual IN (-1,0,@idProceso) OR S.idProcesoActual IS NULL)
					AND S.idEstatus = 1 AND M.idEstatus = 1
			)
			SELECT *
			FROM cte2
			WHERE cte2.codigoBarras LIKE @sCadenaBusqueda
			ORDER BY id
		END
		ELSE
		BEGIN
			WITH cte3 (id, codigoBarras, codigo, tipo, perfil, clase, estatusCalidad, procesoActual)
			AS (
				SELECT  CONCAT(@clase,'-',M.idMarca,'-',S.idSerie)	AS id
					   ,CONCAT(@clase,'-',M.idMarca,'-',S.idSerie)	AS codigoBarras
					   ,codigoMarca									AS codigo
					   ,'MARCA'										AS tipo
					   ,'N/A'										AS perfil
					   ,'N/A'										AS clase
					   ,ISNULL(E.nombreEstatus,'LIBERADO')			AS estatusCalidad
					   ,@nombreProceso								AS procesoActual
				FROM cmiMarcas M
				INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
				INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
				INNER JOIN cmiEtapas ET ON ET.idEtapa = PM.idEtapa
				INNER JOIN cmiSeries S ON M.idMarca = S.idMarca
				LEFT JOIN cmiEstatus E ON E.idEstatus = S.idEstatusCalidad
				WHERE ET.idEtapa = @idEtapa 
					AND S.idProcesoActual = @idProceso
					AND S.idEstatus = 1 AND M.idEstatus = 1
			)
			SELECT *
			FROM cte3
			WHERE cte3.codigoBarras LIKE @sCadenaBusqueda
			ORDER BY id
		END
	END
END
----------------------




