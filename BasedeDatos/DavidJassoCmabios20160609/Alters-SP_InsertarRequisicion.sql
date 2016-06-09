
/****** Object:  StoredProcedure [dbo].[usp_InsertarRequisicion]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_InsertarRequisicion] 
     @idRequerimiento INT
	,@idEstatus INT
	,@idOrigenRequisicion INT
	,@idAlmacen INT
	,@usuarioCreacion INT
	,@idMaterial INT
	,@cantidadSolicitada INT
	,@causaRequisicion VARCHAR(100)
	,@Unidad INT
	,@idRequisicion INT
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 01/Marzo/16
-- Descripcion: Insertar una nueva Requisición
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
DECLARE @Existe INT = 0
	,@UltimoID INT = 0
	,@IdReq INT = 0
	,@Inserta INT;

BEGIN
	SET NOCOUNT ON;

	SELECT @Existe = COUNT(*)
	FROM cmiRequisiciones req
	INNER JOIN cmiDetallesRequisicion re ON req.idRequisicion = re.idRequisicion
	WHERE req.idRequerimiento = @idRequerimiento
		AND re.idOrigenRequisicion = 1

	SELECT @Inserta = COUNT(*)
	FROM cmiRequisiciones req
	INNER JOIN cmiDetallesRequisicion re ON req.idRequisicion = re.idRequisicion
	WHERE req.idRequerimiento = @idRequerimiento
		AND re.idRequisicion = @idRequisicion

	IF @idOrigenRequisicion = 1
	BEGIN
		IF @Existe = 0
		BEGIN
			IF @Inserta = 0
			BEGIN
				INSERT INTO cmiRequisiciones (
					fechaCreacion
					,fechaUltModificacion
					,idEstatus
					,fechaSolicitud
					,idRequerimiento
					,folioRequisicion
					,idAlmacen
					,usuarioCreacion
					)
				VALUES (
					getdate()
					,getdate()
					,@idEstatus
					,getdate()
					,@idRequerimiento
					,@idRequerimiento
					,@idAlmacen
					,@usuarioCreacion
					)
			END

			
		END
		SELECT @IdReq = idRequisicion -- @IdReq = 59
			FROM cmiRequisiciones
			WHERE idRequerimiento = @idRequerimiento

			SELECT @UltimoID = ISNULL(MAX(T1.idDetalleRequisicion) + 1, 1) -- @UltimoID = 2
			FROM cmiRequisiciones T0
			INNER JOIN cmiDetallesRequisicion T1 ON T0.idRequisicion = T1.idRequisicion
			WHERE T0.idRequerimiento = @idRequerimiento
				AND T1.idRequisicion = @IdReq

			INSERT INTO cmiDetallesRequisicion (
				idRequisicion
				,idDetalleRequisicion
				,idMaterial
				,cantidadSolicitada
				,idUnidadMedida
				,idOrigenRequisicion
				,causaRequisicion
				)
			VALUES (
				@IdReq
				,@UltimoID
				,@idMaterial
				,@cantidadSolicitada
				,@Unidad
				,@idOrigenRequisicion
				,@causaRequisicion
				)

		SELECT @IdReq
	END
	ELSE
	BEGIN
		IF @idOrigenRequisicion = 2
		BEGIN
			IF @Inserta = 0
			BEGIN
				INSERT INTO cmiRequisiciones (
					fechaCreacion
					,fechaUltModificacion
					,idEstatus
					,fechaSolicitud
					,idRequerimiento
					,folioRequisicion
					,idAlmacen
					,usuarioCreacion
					)
				VALUES (
					getdate()
					,getdate()
					,@idEstatus
					,getdate()
					,@idRequerimiento
					,@idRequerimiento
					,@idAlmacen
					,@usuarioCreacion
					)
			END

			SELECT @IdReq = idRequisicion
			FROM cmiRequisiciones
			WHERE idRequerimiento = @idRequerimiento

			SELECT @UltimoID = ISNULL(MAX(T1.idDetalleRequisicion) + 1, 1)
			FROM cmiRequisiciones T0
			INNER JOIN cmiDetallesRequisicion T1 ON T0.idRequisicion = T1.idRequisicion
			WHERE T0.idRequerimiento = @idRequerimiento
				AND T1.idRequisicion = @IdReq

			INSERT INTO cmiDetallesRequisicion (
				idRequisicion
				,idDetalleRequisicion
				,idMaterial
				,cantidadSolicitada
				,idUnidadMedida
				,idOrigenRequisicion
				,causaRequisicion
				)
			VALUES (
				@IdReq
				,@UltimoID
				,@idMaterial
				,@cantidadSolicitada
				,@Unidad
				,@idOrigenRequisicion
				,@causaRequisicion
				)

			SELECT @IdReq
		END
		ELSE
		BEGIN
			SELECT '0'
		END
	END
END

GO
