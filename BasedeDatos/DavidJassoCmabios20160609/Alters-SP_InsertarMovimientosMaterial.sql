
/****** Object:  StoredProcedure [dbo].[usp_InsertarMovimientosMaterial]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_InsertarMovimientosMaterial]	
	@idMaterial int,
	@idAlmacen int,
	@Cantidad float,
	@TipoMovto int,
	@idDocumento int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Abril/16
-- Descripcion: Insertar un nuevo movimeinto de material
-- Parametros de salida:
-- Parametros de entrada: @idMaterial @idAlmacen @Cantidad @usuarioCreacion
******************************************
*/
DECLARE @Documento int, @DesMovto Varchar(1), @ExisteM int
BEGIN
BEGIN TRAN
	SET NOCOUNT ON;

	SELECT @DesMovto = tipoMovtoMaterial FROM cmiTiposMovtoMaterial
	WHERE idTipoMovtoMaterial = @TipoMovto

	SELECT @ExisteM = count(*)FROM cmiInventarios
	WHERE idMaterial = @idMaterial
	And idAlmacen = @idAlmacen
	SET @Documento = @idDocumento
	IF @idDocumento = '' 
	BEGIN
		SELECT @Documento = ISNULL(MAX(documentoMovimientoMaterial),0) + 1 FROM cmiMovimientosMaterial
		
		INSERT INTO cmiMovimientosMaterial
			   (fechaCreacion
			   ,fechaUltModificacion
			   ,usuarioCreacion
			   ,idMaterial
			   ,idAlmacen
			   ,cantidadMovimientoMaterial
			   ,idTipoMovtoMaterial
			   ,documentoMovimientoMaterial
			   )
		 VALUES
			   (GETDATE()
			   ,GETDATE()
			   ,@usuarioCreacion
			   ,@idMaterial
			   ,@idAlmacen
			   ,@Cantidad
			   ,@TipoMovto
			   ,@Documento)

		IF @DesMovto = 'E'
		BEGIN
			IF @ExisteM = 0
			BEGIN
				INSERT INTO cmiInventarios (idMaterial, idAlmacen, cantidadInventario, idUsuario, fechaUltModificacion)
				VALUES (@idMaterial, @idAlmacen, @Cantidad, @usuarioCreacion, GETDATE());

				INSERT INTO cmiKardex (idMaterial, idAlmacen, idTipoMovtoMaterial, documentoKardex, cantidadKardex, fechaCreacion, usuarioCreacion)
				VALUES (@idMaterial, @idAlmacen, @TipoMovto,@Documento, @Cantidad, GETDATE(), @usuarioCreacion);
			END
			ELSE
			BEGIN
		 		UPDATE cmiInventarios SET cantidadInventario = cantidadInventario + @Cantidad
				WHERE idMaterial = @idMaterial
					AND idAlmacen = @idAlmacen;

				INSERT INTO cmiKardex (idMaterial, idAlmacen, idTipoMovtoMaterial, documentoKardex, cantidadKardex, fechaCreacion, usuarioCreacion)
				VALUES (@idMaterial, @idAlmacen, @TipoMovto,@Documento, @Cantidad, GETDATE(), @usuarioCreacion);
			END
		END
		ELSE
		BEGIN
		 	UPDATE cmiInventarios SET cantidadInventario = cantidadInventario - @Cantidad
			WHERE idMaterial = @idMaterial
				AND idAlmacen = @idAlmacen;

			INSERT INTO cmiKardex (idMaterial, idAlmacen, idTipoMovtoMaterial, documentoKardex, cantidadKardex, fechaCreacion, usuarioCreacion)
			VALUES (@idMaterial, @idAlmacen, @TipoMovto, @Documento, @Cantidad, GETDATE(), @usuarioCreacion);
		END
	END
	ELSE
	BEGIN
		INSERT INTO cmiMovimientosMaterial
			   (fechaCreacion
			   ,fechaUltModificacion
			   ,usuarioCreacion
			   ,idMaterial
			   ,idAlmacen
			   ,cantidadMovimientoMaterial
			   ,idTipoMovtoMaterial
			   ,documentoMovimientoMaterial
			   )
		 VALUES
			   (GETDATE()
			   ,GETDATE()
			   ,@usuarioCreacion
			   ,@idMaterial
			   ,@idAlmacen
			   ,@Cantidad
			   ,@TipoMovto
			   ,@idDocumento)

			IF @DesMovto = 'E'
			BEGIN
				UPDATE cmiInventarios SET cantidadInventario = cantidadInventario + @Cantidad
				WHERE idMaterial = @idMaterial
					AND idAlmacen = @idAlmacen

				INSERT INTO cmiKardex (idMaterial, idAlmacen, idTipoMovtoMaterial, documentoKardex, cantidadKardex, fechaCreacion, usuarioCreacion)
				VALUES (@idMaterial, @idAlmacen, @TipoMovto, @idDocumento, @Cantidad, GETDATE(), @usuarioCreacion);
			END
			ELSE
			BEGIN
				UPDATE cmiInventarios SET cantidadInventario = cantidadInventario - @Cantidad
				WHERE idMaterial = @idMaterial
					AND idAlmacen = @idAlmacen

				INSERT INTO cmiKardex (idMaterial, idAlmacen, idTipoMovtoMaterial, documentoKardex, cantidadKardex, fechaCreacion, usuarioCreacion)
				VALUES (@idMaterial, @idAlmacen,@TipoMovto , @idDocumento, @Cantidad, GETDATE(), @usuarioCreacion);
			END
    END  
  IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			COMMIT TRAN  SELECT distinct documentoMovimientoMaterial FROM cmiMovimientosMaterial WHERE documentoMovimientoMaterial = @Documento
		END    
END



GO