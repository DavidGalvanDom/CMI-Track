USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionAvanceProyecto]    Script Date: 20/04/2016 05:39:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_CargarReporteProduccionAvanceProyecto]
(
	@IdProyecto int
)

/*

EXEC usp_CargarReporteProduccionAvanceProyecto 1

*/
AS
BEGIN
	SET NOCOUNT ON;
	-- Declaracion de Variables del SP ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	DECLARE @Avance DECIMAL(5,2)
	DECLARE @FechaIni DATETIME
	DECLARE @FechaFin DATETIME
	
	-- Declaracion de Variables de cursores ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	DECLARE @curIdEtapa INT
	DECLARE @curIdPlanoMontaje INT
	DECLARE @curNombreEtapa NVARCHAR(50)
	DECLARE @curNombrePlanoMontaje NVARCHAR(50)

	-- Asignacion de valores ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	SET @Avance = 0

	-- Tablas temporales ==  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	BEGIN
		IF EXISTS(SELECT object_id FROM tempdb.sys.objects WHERE name LIKE '#ReporteProduccionAvanceProyecto')
			DROP TABLE #ReporteProduccionAvanceProyecto;

		CREATE TABLE #ReporteProduccionAvanceProyecto
					(	IdRegistro INT,			NombreEtapa VARCHAR(50),	NombrePlanoMontaje VARCHAR(50),
						Avance DECIMAL(5,2),	FechaInicio DATETIME,		FechaFin DATETIME)
	END

	-- Declaracion de cursor ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
	BEGIN
		-- CURSOR PLANOS
		DECLARE cPlanosMontaje CURSOR LOCAL FAST_FORWARD FOR
			SELECT PM.idPlanoMontaje, E.idEtapa, E.nombreEtapa, PM.nombrePlanoMontaje
			FROM cmiProyectos P
			INNER JOIN cmiEtapas E ON E.idProyecto = P.idProyecto
			INNER JOIN cmiPlanosMontaje PM ON PM.idEtapa = E.idEtapa
			WHERE P.idProyecto = @IdProyecto
				AND E.idEstatus = 1
				AND PM.idEstatus = 1
	END

	--   ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---
	OPEN cPlanosMontaje
	FETCH NEXT FROM cPlanosMontaje
		  INTO @curIdPlanoMontaje, @curIdEtapa, @curNombreEtapa, @curNombrePlanoMontaje 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Calculo del avance por plano de montaje
		WITH cte1 (idProceso, Porcentaje) AS (
			SELECT RF.idProceso, 
				   PERCENT_RANK() OVER (ORDER BY secuenciaRutaFabricacion) AS Porcentaje
			FROM cmiRutasFabricacion RF
			INNER JOIN cmiProyectos P ON RF.idCategoria = P.idCategoria
			WHERE P.idProyecto = 1--@IdProyecto
		)
		SELECT @Avance = AVG(ISNULL(cte1.Porcentaje,0)) * 100
		FROM cmiSeries S
		INNER JOIN cmiMarcas M ON M.idMarca = S.idMarca
		INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
		INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
		LEFT JOIN cte1 ON S.idProcesoActual = cte1.idProceso
		WHERE PM.idPlanoMontaje = @curIdPlanoMontaje

		--Calculo de Fecha de Inicio
		
		SELECT @FechaIni = MIN(HA.fechaAvance), @FechaFin = MAX(HA.fechaAvance)
		FROM cmiHistoricoAvances HA
		INNER JOIN cmiMarcas M ON M.idMarca = HA.idMarca_Submarca
		INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
		INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
		WHERE HA.claseAvance = 'M' AND PM.idPlanoMontaje = @curIdPlanoMontaje

		IF (@Avance < 100) SET @FechaFin = GETDATE()
		
		INSERT INTO #ReporteProduccionAvanceProyecto
					(IdRegistro,		 NombreEtapa,		NombrePlanoMontaje,
					 Avance,			 FechaInicio,		FechaFin)
			VALUES  (@curIdPlanoMontaje, @curNombreEtapa,	@curNombrePlanoMontaje,
					 @Avance,			 @FechaIni,			@FechaFin)
		
		FETCH NEXT FROM cPlanosMontaje
		  INTO @curIdPlanoMontaje, @curIdEtapa, @curNombreEtapa, @curNombrePlanoMontaje
	END
	CLOSE cPlanosMontaje
	DEALLOCATE cPlanosMontaje
	---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---
	SELECT	IdRegistro, 
			NombreEtapa,
			NombrePlanoMontaje,
			ISNULL(Avance,0) AS Avance,
			CONVERT(VARCHAR(10),ISNULL(FechaInicio,GETDATE()),103) AS FechaInicio,
			CONVERT(VARCHAR(10),ISNULL(FechaFin,GETDATE()),103) AS FechaFin
	  FROM #ReporteProduccionAvanceProyecto

	--   ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---  ---
END
