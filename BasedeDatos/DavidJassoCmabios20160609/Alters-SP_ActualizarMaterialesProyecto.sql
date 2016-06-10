/****** Object:  StoredProcedure [dbo].[usp_ActualizarMaterialesProyecto]    Script Date: 09/06/2016 10:06:56 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[usp_ActualizarMaterialesProyecto]	
	@idMaterialProyecto int,
	@idMaterial int,
	@idAlmacen int,
	@Cantidad float,
	@Usuario int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 05/Febrero/16
-- Descripcion: Actualiza la Materiales Proyecto
-- Parametros de salida:
-- Parametros de entrada: @idMaterial @idAlmacen @Cantidad @Usuario
******************************************
*/
DECLARE @Doc int

BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiMaterialesProyecto SET fechaUltModificacion = GETDATE()
											,cantidadMaterialProyecto = @Cantidad
	WHERE idMaterialProyecto = @idMaterialProyecto

	UPDATE cmiInventarios SET cantidadInventario = cantidadInventario - @Cantidad
	WHERE idMaterial = @idMaterial
		AND idAlmacen = @idAlmacen

	select @Doc = documentoMaterialProyecto  from cmiMaterialesProyecto
	where idMaterialProyecto = @idMaterialProyecto

	INSERT INTO cmiKardex (idMaterial, idAlmacen, idTipoMovtoMaterial, documentoKardex, cantidadKardex, fechaCreacion, usuarioCreacion)
	VALUES (@idMaterial, @idAlmacen, 2, @Doc, @Cantidad, GETDATE(), @Usuario);
END
