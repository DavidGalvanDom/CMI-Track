USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarAlmacen]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_ActualizarAlmacen]
	@IdAlmacen int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Actualizar Almacen
-- Parametros de salida:
-- Parametros de entrada: @IdAlmacen @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiAlmacenes]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreAlmacen] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idAlmacen = @IdAlmacen

END










GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCalidadProceso]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[usp_ActualizarCalidadProceso]
	@IdProceso int,
	@IdTipoCalidad int,
	@secuencia int,
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Actualizar RutaFabricacion
-- Parametros de salida:
-- Parametros de entrada: @IdProceso @IdTipoCalidad @secuencia @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [dbo].[cmiCalidadProceso]
	   SET  [fechaUltModificacion] = GETDATE()
		   ,[secuenciaCalidadProceso] = @secuencia
		   ,[idEstatus] = @idEstatus
	 WHERE [idProceso] = @idProceso AND [idTipoCalidad] = @IdTipoCalidad

END








GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCantidadRecibida]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarCantidadRecibida]	
	@idMaterial int,
	@Cantidad int,
	@Serie varchar(20),
	@Factura varchar(20),
	@Proveedor varchar(100),
	@FechaFac varchar(10),
	@idRequerimiento int,
	@idRequisicion int,
	@Item int,
	@Usuario int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Actualiza la cantidad recibida de cada item
-- Parametros de salida:
-- Parametros de entrada: @idMaterial  @Almacen @Cantidad
******************************************
*/
DECLARE @Almacen int
BEGIN
	
	SET NOCOUNT ON;

	select @Almacen = idAlmacen from cmiRequisiciones
	where idRequisicion = @idRequisicion 
	and idRequerimiento = @idRequerimiento  

	
	UPDATE cmiDetallesRequisicion SET cantidadRecibida = ( CASE WHEN cantidadRecibida IS null THEN 0 ELSE cantidadRecibida END ) + @Cantidad
	WHERE idRequisicion = @idRequisicion
	and idMaterial= @idMaterial
	and idDetalleRequisicion = @Item

	UPDATE cmiRequisiciones SET fechaUltModificacion = getdate(),
					fechaRecepcion = getdate(),
					serieRequisicion = @Serie,
					facturaRequisicion = @Factura,
					proveedorRequisicion = @Proveedor,
					fechaFacturaRequisicion = convert(datetime, @FechaFac, 101)
	WHERE idRequerimiento = @idRequerimiento
	and idRequisicion= @idRequisicion


    UPDATE cmiInventarios SET cantidadInventario = cantidadInventario  + @Cantidad, idUsuario = @Usuario,
			fechaUltModificacion = getdate()
	WHERE idMaterial = @idMaterial
		and idAlmacen= @Almacen

	INSERT INTO cmiKardex (idMaterial, idAlmacen, idTipoMovtoMaterial, cantidadKardex, fechaCreacion, usuarioCreacion)
	VALUES (@idMaterial, @Almacen, 1, @Cantidad, GETDATE(), @Usuario);

	select 1

END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCategoria]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarCategoria]	
	@idCategoria int,
	@estatus int,
	@nombreCategoria varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza la categoria
-- Parametros de salida:
-- Parametros de entrada: @idCategoria @usuarioCreacion @estatus @nombreCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiCategorias SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreCategoria = @nombreCategoria
	WHERE idCategoria = @idCategoria
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCliente]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarCliente]	
	@idCliente int,
	@estatus int,
	@nombreCliente varchar(100),
	@direccionEntregaCliente varchar(100),
	@coloniaCliente varchar(100),
	@cpCliente int,
	@ciudadCliente varchar(100),
	@estadoCliente varchar(100),
	@paisCliente varchar(100),
	@contactoCliente varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza la categoria
-- Parametros de salida:
-- Parametros de entrada: @idCategoria @usuarioCreacion @estatus @nombreCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiClientes SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreCliente = @nombreCliente
											   ,direccionEntregaCliente = @direccionEntregaCliente
											   ,coloniaCliente = @coloniaCliente
											   ,cpCliente = @cpCliente
											   ,ciudadCliente = @ciudadCliente
											   ,estadoCliente = @estadoCliente
											   ,paisCliente = @paisCliente
											   ,contactoCliente = @contactoCliente
	WHERE idCliente = @idCliente
END


GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarDepartamento]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarDepartamento]
	@idDepartamento int,		
	@idEstatus int,
	@Nombre varchar(255)	
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 06/Febrero/2016
-- Descripcion: Actualiza los datos del Departamento
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE [cmiDepartamentos] SET
					    [idEstatus] = @idEstatus
					   ,[nombreDepartamento] = @Nombre					   
					   ,[fechaUltModificacion] = GETDATE()
     WHERE idDepartamento = @idDepartamento
     
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarEtapa]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarEtapa]	
	@estatusEtapa int,
	@nombreEtapa varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),	
	@infoGeneral varchar(250),
	@claveEtapa varchar(10),	
	@idEtapa int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 20/Febrero/16
-- Descripcion: Se actualiza la informacion de la Etapa
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [cmiEtapas] SET           
           [fechaUltModificacion] = GETDATE()           
           ,[nombreEtapa] = @nombreEtapa
           ,[estatusEtapa] = @estatusEtapa
           ,[fechaInicioEtapa] = convert(datetime, @fechaInicio, 103)
           ,[fechaFinEtapa] = convert(datetime, @fechaFin, 103)
           ,[infGeneralEtapa] = @infoGeneral
		   ,[claveEtapa] = @claveEtapa
     WHERE idEtapa =  @idEtapa
     
END





GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarGrupo]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE  PROCEDURE [dbo].[usp_ActualizarGrupo]
	@IdGrupo int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Actualizar Grupo
-- Parametros de salida:
-- Parametros de entrada: @IdGrupo @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiGrupos]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreGrupo] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idGrupo = @IdGrupo

END









GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarMarca]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarMarca]
	@idEstatus int,
	@nombreMarca varchar(50),	
	@codigoMarca varchar(20),
	@pesoMarca float,	
	@piezasMarca int,	
	@idPlanoDespiece int,
	@idMarca int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 01/Marzo/16
-- Descripcion: Actualiza la informaciond e la Marca
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;
	-- Declaracion de variables
	DECLARE  @cont int = 0
			,@piezasMarcaAnterior int = 0;
	
	SELECT @piezasMarcaAnterior = piezasMarca  
	FROM [dbo].[cmiMarcas]
	WHERE idMarca = @idMarca

	BEGIN TRANSACTION;

	BEGIN TRY
		UPDATE [dbo].[cmiMarcas]
		   SET [fechaUltModificacion] = getdate()
			  ,[idEstatus] = @idEstatus
			  ,[codigoMarca] = @codigoMarca
			  ,[nombreMarca] = @nombreMarca
			  ,[piezasMarca] = @piezasMarca
			  ,[pesoMarca] = @pesoMarca		  
		 WHERE idMarca = @idMarca;

		 IF @piezasMarcaAnterior <> @piezasMarca
		 BEGIN

		 DELETE cmiSeries WHERE idMarca = @idMarca;

		 WHILE @cont < @piezasMarca
			BEGIN
		
				INSERT INTO cmiSeries ( idMarca
									   ,idSerie
									   ,idEstatus
									   ,idUsuario )
						VALUES		  ( @idMarca
									   ,[dbo].[ufn_getCodigoSerie] (@cont)
									   ,@idEstatus
									   ,@usuarioCreacion);
				SET @cont = @cont + 1;

			END;
		END;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION;
	END CATCH;	
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarMaterial]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarMaterial]	
	@idMaterial int,
	@estatus int,
	@nombreMaterial varchar(100),
	@anchoM numeric,
	@idUMAncho int,
	@largoM numeric,
	@idUMLargo int,
	@pesoMaterial numeric,
	@idUMPeso int,
	@calidadMaterial varchar(20),
	@idTipoMaterial int,
	@idGrupo int,
	@observacionesMaterial varchar(100)

AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el Material
-- Parametros de salida:
-- Parametros de entrada: @idMaterial @estatus @nombreMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiMateriales SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreMaterial = @nombreMaterial
											   ,anchoMaterial = @anchoM
											   ,idUMAncho = @idUMAncho
											   ,largoMaterial = @largoM
											   ,idUMLargo = @idUMLargo
											   ,pesoMaterial = @pesoMaterial
											   ,idUMPeso = @idUMPeso
											   ,calidadMaterial = @calidadMaterial
											   ,idTipoMaterial = @idTipoMaterial
											   ,idGrupo = @idGrupo
											   ,observacionesMaterial = @observacionesMaterial
	WHERE idMaterial = @idMaterial
END




GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarMaterialesProyecto]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarMaterialesProyecto]	
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


GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarOrigenReq]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarOrigenReq]	
	@idOrigenRequisicion int,
	@estatus int,
	@nombreOrigenRequisicion varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el origen de la requisicion
-- Parametros de salida:
-- Parametros de entrada: @idOrigenRequisicion @estatus @nombreOrigenRequisicion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiOrigenesRequisicion SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreOrigenRequisicion = @nombreOrigenRequisicion
	WHERE idOrigenRequisicion = @idOrigenRequisicion
END


GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarPlanoDespiece]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarPlanoDespiece]
	@idEstatus int,
	@nombrePlanoDespiece varchar(50),	
	@codigoPlanoDespiece varchar(50),
	@infoGeneral varchar(250),
	@archivoPlanoDespiece varchar(100),	
	@idTipoConstruccion int,
	@idPlanoMontaje int,
	@idPlanoDespiece int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/Febrero/16
-- Descripcion: Se actuliza la informacion de Plano Despiece
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
			
	UPDATE  [cmiPlanosDespiece] SET			   
			    [fechaUltModificacion] = GETDATE()
			   ,[idEstatus] = @idEstatus			   
			   ,[codigoPlanoDespiece] = @codigoPlanoDespiece
			   ,[nombrePlanoDespiece] = @nombrePlanoDespiece
			   ,[idTipoConstruccion] = @idTipoConstruccion
			   ,[infGeneralPlanoDespiece] = @infoGeneral
			   ,[archivoPlanoDespiece] = @archivoPlanoDespiece
	 WHERE [idPlanoDespiece] = @idPlanoDespiece
	 and [idPlanoMontaje] = @idPlanoMontaje

END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarPlanoMontaje]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarPlanoMontaje]
	@idEstatus int,
	@nombrePlanoMontaje varchar(50),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@codigoPlanoMontaje varchar(20),
	@infoGeneral varchar(250),
	@archivoPlanoProyecto varchar(100),
	@idEtapa int,
	@idPlanoMontaje int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 22/Febrero/16
-- Descripcion: Actualiza los datos de un Plano de Montaje
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;
			
	UPDATE [cmiPlanosMontaje] SET
            [fechaUltModificacion] = GETDATE()
           ,[idEstatus] = @idEstatus
           ,[idEtapa] = @idEtapa
           ,[codigoPlanoMontaje] = @codigoPlanoMontaje
           ,[nombrePlanoMontaje] = @nombrePlanoMontaje
           ,[fechaInicioPlanoMontaje] = convert(datetime, @fechaInicio, 103)
           ,[fechaFinPlanoMontaje] = convert(datetime, @fechaFin, 103)
           ,[infGeneralPlanoMontaje] = @infoGeneral
           ,[archivoPlanoMontaje] = @archivoPlanoProyecto
     WHERE idPlanoMontaje = @idPlanoMontaje
      

END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarProceso]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarProceso]
	@IdProceso int,
	@Nombre varchar(50),
	@idTipoProceso int,
	@idEstatus int,
	@claseAvance char(1)
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 10/Febrero/16
-- Descripcion: Actualizar Proceso
-- Parametros de salida:
-- Parametros de entrada: @IdGrupo @Nombre @idTipoProceso @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [dbo].[cmiProcesos]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[idEstatus] = @idEstatus
		  ,[nombreProceso] = @Nombre
		  ,[idTipoProceso] = @idTipoProceso
		  ,[claseAvance] = @claseAvance
	 WHERE idProceso = @IdProceso

END


GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarProyecto]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarProyecto]
	@nombreProyecto varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@codigoProyecto varchar(20),
	@revisionProyecto varchar(3),
	@fechaRevision varchar(10),
	@idCategoria int,
	@estatusProyecto int,
	@idCliente int,
	@infoGeneral varchar(250),
	@archivoPlanoProyecto varchar(100),
	@usuarioCreacion int,
	@idProyecto int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 16/Febrero/16
-- Descripcion: Actualiza la informacion del Proyecto
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [cmiProyectos] SET
						 [fechaUltModificacion] = GETDATE()
						,[codigoProyecto] = @codigoProyecto
						,[nombreProyecto] = @nombreProyecto
						,[idCategoria] = @idCategoria
						,[fechaInicioProyecto] = convert(datetime, @fechaInicio, 103)
						,[fechaFinProyecto] = convert(datetime, @fechaFin, 103)
						,[estatusProyecto] = @estatusProyecto
						,[idCliente] = @idCliente
						,[archivoPlanoProyecto] = @archivoPlanoProyecto
						,[infGeneralProyecto] = @infoGeneral
	WHERE [idProyecto] = @idProyecto
	AND [revisionProyecto] = @revisionProyecto
           
   
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarRemision]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarRemision]	
	@fechaEnvio varchar(10),
	@idCliente int,
	@transporte varchar(100),
	@placas varchar(20),
	@conductor varchar(150),
	@idRemision int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/Abril/16
-- Descripcion: Actualiza los datos de la Remision
-- Parametros de salida:
-- Parametros de entrada: @fechaEnvio 	@idCliente	@transporte 	@placas 	@conductor  @usuarioCreacion,@idProyecto,@idEtapa,@idRemision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [cmiRemisiones] SET
			 [fechaEnvio] = convert(datetime, @fechaEnvio, 103)
			,[fechaUltModificacion]= GETDATE()
			,[transporte] = @transporte
			,[placas]= @placas
			,[conductor] = @conductor
			,[idCliente] = @idCliente
	WHERE idRemision = @idRemision;

	UPDATE cmiOrdenesEmbarque SET
			estatusOrdenEmbarque = 1,
			fechaUltModificacion = Getdate()
	WHERE idOrdenEmbarque IN (SELECT idOrdenEmbarque 
							  FROM  cmiRemisionDetalle 
							  WHERE idRemision = @idRemision);

	DELETE cmiRemisionDetalle 
	WHERE idRemision = @idRemision;

END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarRequiMateriales]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarRequiMateriales]	
	@idRequerimiento int,
	@idMaterial int,
	@cantidadSolicitada int,
	@Unidad int,
	@idItem int,
	@idRequisicion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el material dela requisicion
-- Parametros de salida:
-- Parametros de entrada: @idRequerimiento ,@idMaterial ,	@cantidadSolicitada ,@Unidad ,	@idItem ,@idRequisicion 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	if (SELECT autorizadoRequisicion  
		FROM cmiRequisiciones 
		where idRequisicion = @idRequisicion) = 1
	BEGIN
		select '-3';
		return;
	END
	ELSE
	BEGIN

		UPDATE DR
			SET  cantidadSolicitada = @cantidadSolicitada
				,idUnidadMedida = @Unidad
		 FROM cmiDetallesRequisicion AS DR
		INNER JOIN cmiRequisiciones R
		ON DR.idRequisicion = R.idRequisicion
		WHERE R.idRequerimiento = @idRequerimiento
		and DR.idDetalleRequisicion = @idItem
		and R.idRequisicion = @idRequisicion;

		select '-1';
	END
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarRutaFabricacion]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_ActualizarRutaFabricacion]
	@IdRutaFabricacion int,
	@idCategoria int,
	@secuencia int,
	@idProceso int,
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Actualizar RutaFabricacion
-- Parametros de salida:
-- Parametros de entrada: @IdRutaFabricacion @idCategoria @secuencia @idProceso @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE [dbo].[cmiRutasFabricacion]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[idEstatus] = @idEstatus
		  ,[idCategoria] = @idCategoria
		  ,[secuenciaRutaFabricacion] = @secuencia
		  ,[idProceso] = @idProceso
	 WHERE idRutaFabricacion = @IdRutaFabricacion

END







GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarSubMarca]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarSubMarca]
	@idEstatus int,
	@idMarca int,
	@codigoSubMarca varchar(20),		       
	@perfilSubMarca varchar(50),
	@piezasSubMarca int,
	@corteSubMarca float,
	@longitudSubMarca float,
	@anchoSubMarca float,
	@gradoSubMarca varchar(20),
	@kgmSubMarca float,
	@totalLASubMarca float,
	@pesoSubMarca float,
	@claseSubMarca char(1),
	@totalSubMarca float,
	@alturaSubMarca float,
	@idSubMarca int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 09/Marzo/16
-- Descripcion: Actualiza la informacion de la SubMarca
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/

BEGIN
	
	SET NOCOUNT ON;
		
	UPDATE [cmiSubMarcas] SET
           [fechaUltModificacion] = GETDATE()
           ,[idEstatus] = @idEstatus
           ,[idMarca] = @idMarca
           ,[codigoSubMarca] = @codigoSubMarca
           ,[perfilSubMarca] = @perfilSubMarca
           ,[piezasSubMarca] = @piezasSubMarca
           ,[corteSubMarca] = @corteSubMarca
           ,[longitudSubMarca] = @longitudSubMarca
           ,[anchoSubMarca] = @anchoSubMarca
           ,[gradoSubMarca] = @gradoSubMarca
           ,[kgmSubMarca] = @kgmSubMarca
           ,[totalLASubMarca] = @totalLASubMarca
		   ,[claseSubMarca] = @claseSubMarca
           ,[pesoSubMarca] = @pesoSubMarca
		   ,[totalSubMarca] = @totalSubMarca
		   ,[alturaSubMarca] = @alturaSubMarca
    WHERE idSubMarca = @idSubMarca
          

END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoCalidad]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE  PROCEDURE [dbo].[usp_ActualizarTipoCalidad]
	@IdTipoCalidad int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Actualizar Tipo de Calidad
-- Parametros de salida:
-- Parametros de entrada: @IdTipoCalidad @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiTiposCalidad]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreTipoCalidad] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idTipoCalidad = @IdTipoCalidad

END








GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoConstruccion]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarTipoConstruccion]	
	@idTipoConstruccion int,
	@estatus int,
	@nombreTipoConstruccion varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el Tipo de construcción
-- Parametros de salida:
-- Parametros de entrada: @idTipoConstruccion @usuarioCreacion @estatus @nombreTipoConstruccion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiTiposConstruccion SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreTipoConstruccion = @nombreTipoConstruccion
	WHERE idTipoConstruccion = @idTipoConstruccion
END




GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMaterial]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[usp_ActualizarTipoMaterial]
	@IdTipoMaterial int,
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Actualizar Tipo de Material
-- Parametros de salida:
-- Parametros de entrada: @IdTipoMaterial @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiTiposMaterial]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreTipoMaterial] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idTipoMaterial = @IdTipoMaterial

END







GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMovtoMaterial]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarTipoMovtoMaterial]	
	@idTipoMovtoMaterial int,
	@estatus char(3),
	@nombreTipoMovtoMaterial varchar(100),
	@tipoMovtoMaterial varchar(1)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el Tipo de Movimiento de material
-- Parametros de salida:
-- Parametros de entrada: @idTipoMovtoMaterial @usuarioCreacion @estatus @nombreTipoMovtoMaterial @tipoMovtoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiTiposMovtoMaterial SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreTipoMovtoMaterial = @nombreTipoMovtoMaterial
											   ,tipoMovtoMaterial = @tipoMovtoMaterial
	WHERE idTipoMovtoMaterial = @idTipoMovtoMaterial
END


GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoProceso]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarTipoProceso]	
	@idTipoProceso int,
	@estatus int,
	@nombreTipoProceso varchar(100)
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el tipo proceso
-- Parametros de salida:
-- Parametros de entrada: @idTipoProceso @usuarioCreacion @estatus @nombreTipoProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE cmiTiposProceso SET fechaUltModificacion = GETDATE()
											   ,idEstatus = @estatus
											   ,nombreTipoProceso = @nombreTipoProceso
	WHERE idTipoProceso = @idTipoProceso
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUnidadMedida]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[usp_ActualizarUnidadMedida]
	@IdUnidadMedida int,
	@NombreCorto varchar(5),
	@Nombre varchar(50),
	@idEstatus int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Actualizar Unidad Medida
-- Parametros de salida:
-- Parametros de entrada: @IdUnidadMedida @NombreCorto @Nombre @Estatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[cmiUnidadesMedida]
	   SET [fechaUltModificacion] = GETDATE()
		  ,[nombreCortoUnidadMedida] = @NombreCorto
		  ,[nombreUnidadMedida] = @Nombre
		  ,[idEstatus] = @idEstatus
	 WHERE idUnidadMedida = @IdUnidadMedida

END






GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUsuario]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarUsuario]
	@idUsuario int,		
	@idEstatus int,
	@Correo varchar(100),
	@Nombre varchar(50),
	@ApePaterno varchar(50),
	@ApeMaterno varchar(50),
	@NombreUsuario varchar(20),
	@Contrasena varchar(20),
	@Puesto varchar(50),
	@Area varchar(50),
	@idDepto int,
	@Autoriza int,
	@idProOrigen int,
	@idProDestino int
	
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 03/Febrero/2016
-- Descripcion: Actualiza los datos del Usuario
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    UPDATE [cmiUsuarios] SET[emailUsuario] = @Correo
					   ,[idEstatus] = @idEstatus
					   ,[nombreUsuario] = @Nombre
					   ,[apePaternoUsuario] = @ApePaterno
					   ,[apeMaternoUsuario] = @ApeMaterno 
					   ,[loginUsuario] = @NombreUsuario
					   ,[passwordUsuario] = @Contrasena 
					   ,[puestoUsuario] = @Puesto
					   ,[areaUsuario] = @Area					   
					   ,[idDepartamento] = @idDepto
					   ,[autorizaRequisiciones] = @Autoriza
					   ,[idProcesoOrigen] = @idProOrigen
					   ,[idProcesoDestino] = @idProDestino					   
					   ,[fechaUltModificacion] = GETDATE()
     WHERE IdUsuario = @IdUsuario
     
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ActulizarOrdenEmbarque]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActulizarOrdenEmbarque]	
	@estatusOE int,
	@observacion varchar(255),
	@idOrdenEmbarque int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 30/Abril/16
-- Descripcion: Se actualiza la informacion de la Orden de embarque
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE cmiOrdenesEmbarque SET
           [fechaUltModificacion] = GETDATE()
           ,[estatusOrdenEmbarque] = @estatusOE
           ,[observacionOrdenEmbarque] = @observacion
     WHERE idOrdenEmbarque =  @idOrdenEmbarque;

END





GO
/****** Object:  StoredProcedure [dbo].[usp_AutentificaUsuario]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_AutentificaUsuario]
	@loginUsuario varchar(20),
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Autentifica al usuario para entrar al sistema
-- Parametros de salida:
-- Parametros de entrada: @idUsuario, @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	SELECT [idUsuario]
      ,[nombreUsuario]
      ,[apePaternoUsuario]
      ,[apeMaternoUsuario]
      ,[puestoUsuario]
      ,[areaUsuario]
      ,[idDepartamento]
      ,[emailUsuario]
      ,[loginUsuario]      
      ,[passwordUsuario]
      ,[autorizaRequisiciones]
      ,[idProcesoOrigen]
      ,[idProcesoDestino]
      ,[fechaCreacion]
  FROM [cmiUsuarios]
  WHERE loginUsuario = @loginUsuario
	and idEstatus = @idEstatus

    
END



GO
/****** Object:  StoredProcedure [dbo].[usp_AutorizarRequisicion]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_AutorizarRequisicion]
	@Autoriza int,
	@idRequisicion int,
	@idRequerimiento int,
	@Usuario int
AS
/*
******************************************
-- Nombre: David JAsso
-- Fecha: 02/Marzo/16
-- Descripcion: Autorizar Requisicion
-- Parametros de salida:
-- Parametros de entrada: @Autoriza
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	UPDATE cmiRequisiciones
	   SET fechaUltModificacion = GETDATE()
		  ,autorizadoRequisicion = @Autoriza
		  ,usuarioAutoriza = @Usuario
	 WHERE idRequisicion = @idRequisicion
	 and idRequerimiento = @idRequerimiento



END




GO
/****** Object:  StoredProcedure [dbo].[usp_BuscaLoginUsuario]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------
CREATE  PROCEDURE [dbo].[usp_BuscaLoginUsuario]	
	@loginUsuario varchar(20),
	@idUsuario int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 08/Febrero/2016
-- Descripcion: Se valida si existe el login de usuario
-- Parametros de salida:
-- Parametros de entrada:  @loginUsuario, @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	if(@idUsuario is null)
		SELECT loginUsuario
		FROM  cmiUsuarios
		WHERE loginUsuario = @loginUsuario
	else
		SELECT loginUsuario
		FROM  cmiUsuarios
		WHERE  idUsuario <> @idUsuario
		and  loginUsuario = @loginUsuario
			
END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarAlmacenes]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarAlmacenes]
	@IdAlmacen int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Almacenes
-- Parametros de salida:
-- Parametros de entrada:  @IdAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiAlmacenes].[idAlmacen]
			,[dbo].[cmiAlmacenes].[fechaCreacion]
			,[dbo].[cmiAlmacenes].[fechaUltModificacion]
			,[dbo].[cmiAlmacenes].[usuarioCreacion]
			,[dbo].[cmiAlmacenes].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiAlmacenes].[nombreAlmacen]
	FROM [dbo].[cmiAlmacenes]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiAlmacenes].[idEstatus]
	WHERE [dbo].[cmiAlmacenes].[idAlmacen] = ISNULL(@IdAlmacen, [dbo].[cmiAlmacenes].[idAlmacen])
		AND [dbo].[cmiAlmacenes].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiAlmacenes].[idEstatus])
		
END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarAvance]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CargarAvance]
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






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarCalidadesProceso]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[usp_CargarCalidadesProceso]
	@IdProceso int,
	@idTipoCalidad int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Se cargan las Relaciones Calidad Proceso
-- Parametros de salida:
-- Parametros de entrada:  @IdProceso @idTipoCalidad @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiCalidadProceso].[idProceso]
			,[dbo].[cmiProcesos].[nombreProceso]
			,[dbo].[cmiCalidadProceso].[idTipoCalidad]
			,[dbo].[cmiTiposCalidad].[nombreTipoCalidad]
			,[dbo].[cmiCalidadProceso].[secuenciaCalidadProceso]
			,[dbo].[cmiCalidadProceso].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiCalidadProceso].[usuarioCreacion]
			,[dbo].[cmiCalidadProceso].[fechaCreacion]
			,[dbo].[cmiCalidadProceso].[fechaUltModificacion]
	FROM [dbo].[cmiCalidadProceso]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiCalidadProceso].[idEstatus]
	INNER JOIN [dbo].[cmiTiposCalidad] ON [dbo].[cmiTiposCalidad].[idTipoCalidad] = [dbo].[cmiCalidadProceso].[idTipoCalidad]
	INNER JOIN [dbo].[cmiProcesos] ON [dbo].[cmiProcesos].[idProceso] = [dbo].[cmiCalidadProceso].[idProceso]
	WHERE [dbo].[cmiCalidadProceso].[idProceso] = ISNULL(@IdProceso, [dbo].[cmiCalidadProceso].[idProceso])
		AND [dbo].[cmiCalidadProceso].[idTipoCalidad] = ISNULL(@idTipoCalidad, [dbo].[cmiCalidadProceso].[idTipoCalidad])
		AND [dbo].[cmiCalidadProceso].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiCalidadProceso].[idEstatus])
		
END







GO
/****** Object:  StoredProcedure [dbo].[usp_CargarCategorias]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarCategorias]
	@idCategoria int,	
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan las categorias
-- Parametros de salida:
-- Parametros de entrada:  @idCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idCategoria
				,ca.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,ca.idEstatus
				,nombreEstatus
				,nombreCategoria	 
	  FROM  cmiCategorias as ca
	  inner join cmiEstatus as es on ca.idEstatus = es.idEstatus
	  where idCategoria = ISNULL(@idCategoria,idCategoria)
	  and ca.idEstatus = ISNULL(@idEstatus,ca.idEstatus)
	  
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarClientes]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarClientes]
	@idCliente int,
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los clientes
-- Parametros de salida:
-- Parametros de entrada:  @idCliente @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idCliente
				,cl.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,cl.idEstatus
				,nombreEstatus
				,nombreCliente
				,direccionEntregaCliente
				,coloniaCliente
				,cpCliente
				,ciudadCliente
				,estadoCliente
				,paisCliente
				,contactoCliente	 
	  FROM  cmiClientes as cl
	  inner join cmiEstatus as es on cl.idEstatus = es.idEstatus
	  where idCliente = ISNULL(@idCliente,idCliente)
	  and cl.idEstatus = ISNULL(@idEstatus,cl.idEstatus)
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarCodigosBarra]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------
CREATE PROCEDURE [dbo].[usp_CargarCodigosBarra]
	@idEtapa int,
	@tipo char(1)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 24/Marzo/16
-- Descripcion: Se cargan los codigos de barra
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @sCadenaBusqueda VARCHAR(200)

	IF @tipo = 'T'
		SET @sCadenaBusqueda = '%';
	ELSE
		SET @sCadenaBusqueda = 	'%' + @tipo + '%';

	WITH cteCodigosBarra (tipo, id, codigo, serie, peso, codigoBarra)
	AS (
		SELECT 'M'				AS tipo
			  ,M.idMarca		AS id
		      ,M.codigoMarca	AS codigo
			  ,S.idSerie		AS serie
			  ,M.pesoMarca		AS peso
			  ,CONCAT('M-',M.idMarca,'-',RIGHT('00' + RTRIM(S.idSerie), 2)) AS codigoBarra
		FROM cmiMarcas M
		INNER JOIN cmiSeries S ON S.idMarca = M.idMarca
		INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
		INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
		WHERE M.idEstatus = 1 AND S.idEstatus = 1 AND PM.idEtapa = @idEtapa
		UNION ALL
		SELECT 'C'					AS tipo
			  ,SM.idSubMarca		AS id
		      ,SM.codigoSubMarca	AS codigo
			  ,'N/A'				AS serie
			  ,SM.pesoSubMarca		AS peso
			  ,CONCAT('S-',SM.idSubMarca,'-00') AS codigoBarra
		FROM cmiSubMarcas SM
		WHERE SM.idEstatus = 1 AND SM.idOrdenProduccion = @idEtapa
	)
	SELECT *
	FROM cteCodigosBarra cte
	WHERE cte.tipo LIKE @sCadenaBusqueda
	ORDER BY codigoBarra
END
----------------------






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDepartamentos]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarDepartamentos]
	@idDepartamento int,
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Departamentos 
-- Parametros de salida:
-- Parametros de entrada:  @idDepartamento, @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idDepartamento]
		  ,T0.[fechaCreacion]
		  ,T0.[idEstatus]
		  ,T1.[nombreEstatus]
		  ,T0.[nombreDepartamento]
		  ,T0.[usuarioCreacion]
  FROM [cmiDepartamentos] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
   WHERE T0.[idDepartamento] = ISNULL(@idDepartamento,T0.[idDepartamento])
	 and T0.[idEstatus] = ISNULL(@idEstatus,T0.[idEstatus])	
	  
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleMaterialesProyecto]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarDetalleMaterialesProyecto]
	@idRequerimiento int,
	@idEtapa int,
	@idProyecto int	,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga el detalle de materiales asignados a un proyecto etapa
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idRequerimiento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select ROW_NUMBER() OVER(ORDER BY Nombre  DESC) AS Row, Nombre, Ancho, Long, sum(recpie) recpie, sum(reckgs) reckgs, sum(solpie) solpie, sum(solkgs) solkgs, 0 reqpie, 0 reqkgs, sum(matpie) matpie, sum(matkgs) matkgs
from  (select t1.nombreMaterial Nombre, t1.anchoMaterial Ancho, t1.largoMaterial Long,0 recpie, 0 reckgs, 0 solpie, 0 solkgs, sum(cantidadMaterialProyecto) matpie, sum(t0.cantidadMaterialProyecto * (t1.largoMaterial *0.3048) * t1.pesoMaterial) matkgs  
from cmiMaterialesProyecto t0
inner join cmiMateriales t1 on t0.idMaterial = t1.idMaterial 
inner join cmiProyectos t2 on t0.idProyecto = t2.idProyecto
inner join cmiEtapas t3 on t0.idEtapa = t3.idEtapa and t2.idProyecto = t3.idProyecto 
where documentoMaterialProyecto  = @idDocumento
group by  t1.nombreMaterial, t1.anchoMaterial, t1.largoMaterial
union all
select t3.nombreMaterial Nombre, t3.anchoMaterial Ancho, t3.largoMaterial Long,sum(cantidadRecibida) recpie,sum(cantidadRecibida * (t3.largoMaterial *0.3048) * t3.pesoMaterial) reckgs, sum(cantidadSolicitada) solpie, sum(cantidadSolicitada * (t3.largoMaterial *0.3048) * t3.pesoMaterial) solkgs, 0 matpie, 0 matkgs
 from cmiRequisiciones t0
inner join  cmiDetallesRequisicion t1 on t0.idRequisicion = t1.idRequisicion 
inner join cmiRequerimientos t2 on t0.idRequerimiento = t2.idRequerimiento 
inner join cmiMateriales t3 on t1.idMaterial = t3.idMaterial 
inner join cmiEtapas t4 on t2.idEtapa = t4.idEtapa 
inner join cmiProyectos t5 on t4.idProyecto = t5.idProyecto 
where t0.idRequerimiento = @idRequerimiento
and t2.idEtapa = @idEtapa
and t4.idProyecto = @idProyecto
group by  t3.nombreMaterial, t3.anchoMaterial, t3.largoMaterial) t1
group by  Nombre, Ancho, Long

--select  ROW_NUMBER() OVER(ORDER BY ma.nombreMaterial  DESC) AS Row,  ma.nombreMaterial Nombre, ma.anchoMaterial Ancho, ma.largoMaterial Long,  sum(cantidadRecibida) recpie,sum(cantidadRecibida * (ma.largoMaterial *0.3048) * ma.pesoMaterial) reckgs, 
--	sum(cantidadSolicitada) solpie, sum(cantidadSolicitada * (ma.largoMaterial *0.3048) * ma.pesoMaterial) solkgs,
--	0 reqpie, 0 reqkgs,
--	sum(cantidadMaterialProyecto) matpie, sum(cantidadMaterialProyecto * (ma.largoMaterial *0.3048) * ma.pesoMaterial) matkgs
--from cmiMateriales  ma
--inner join cmiDetallesRequisicion dr on ma.idMaterial = dr.idMaterial 
--inner join cmiRequisiciones re on dr.idRequisicion = re.idRequisicion 
--inner join cmiRequerimientos rt on re.idRequerimiento = rt.idRequerimiento
--inner join cmiEtapas et on rt.idEtapa = et.idEtapa
--inner join cmiMaterialesProyecto mp on mp.idEtapa = et.idEtapa
--and mp.idProyecto = et.idProyecto
--and mp.idMaterial = ma.idMaterial
--where re.idRequerimiento = 1
--and rt.idEtapa = 1
--and et.idProyecto = 4
--and mp.idEtapa = 1
--and mp.idProyecto = 4
--and mp.documentoMaterialProyecto = 5
--group by  ma.nombreMaterial, ma.anchoMaterial, ma.largoMaterial

END

GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleOrdenEmbar]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarDetalleOrdenEmbar]
	@idOrdenEmbarque int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 21/Abril/16
-- Descripcion: Se carga el datalle de la Orden de Embarque
-- Parametros de salida:
-- Parametros de entrada: @idOrdenEmbarque, @tipo
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT  T0.idOrdenEmbarque,T0.idMarca,
		T6.codigoMarca, T6.pesoMarca, T2.nombreProyecto, 
		T3.claveEtapa, T4.codigoPlanoMontaje, 
		COUNT(idSerie) as piezasMarca,'' as Mensaje,
		(SELECT SUM(estatusEmbarque)
		FROM cmiDetalleOrdenEmbarque
		WHERE idOrdenEmbarque = T0.idOrdenEmbarque
		AND idMarca = T0.idMarca ) piezasLeidas
	FROM cmiDetalleOrdenEmbarque T0
	INNER JOIN cmiOrdenesEmbarque T1 ON T1.idOrdenEmbarque = T0.idOrdenEmbarque 
									AND T1.estatusOrdenEmbarque = 1
	INNER JOIN cmiProyectos T2 ON T2.idProyecto = T1.idProyecto 
	INNER JOIN cmiEtapas T3 ON T3.idEtapa= T1.idEtapa
	INNER JOIN cmiPlanosMontaje T4 ON T4.idEtapa = T1.idEtapa
	INNER JOIN cmiPlanosDespiece T5 ON T4.idPlanoMontaje = T5.idPlanoMontaje
	INNER JOIN cmiMarcas T6 ON T6.idPlanoDespiece = T5.idPlanoDespiece
							AND T6.idMarca = T0.idMarca
	WHERE T0.idOrdenEmbarque = @idOrdenEmbarque
	GROUP BY T0.idOrdenEmbarque,T0.idMarca,
		T6.codigoMarca, T6.pesoMarca, T2.nombreProyecto, 
		T3.claveEtapa, T4.codigoPlanoMontaje;

END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleOrdenEmbar2]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarDetalleOrdenEmbar2]
	@idOrdenEmbarque int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 30/Abril/16
-- Descripcion: Se carga el datalle de la Orden de Embarque
-- Parametros de salida:
-- Parametros de entrada: @idOrdenEmbarque
******************************************
*/

DECLARE @marcasLeidas int = 0;
DECLARE	@numMarcas int = 0;
BEGIN

	SELECT @marcasLeidas= SUM(estatusEmbarque), @numMarcas= count(estatusEmbarque)
	FROM cmiDetalleOrdenEmbarque
	WHERE idOrdenEmbarque = @idOrdenEmbarque

	IF @marcasLeidas = @numMarcas
	BEGIN
		SELECT T0.idOrdenEmbarque,T0.idMarca,
			T6.codigoMarca, T6.pesoMarca, T2.nombreProyecto, 
			T3.claveEtapa, T4.codigoPlanoMontaje, 
			COUNT(idSerie) as piezasMarca,'' as Mensaje,
			(SELECT SUM(estatusEntrega)
			FROM cmiDetalleOrdenEmbarque
			WHERE idOrdenEmbarque = T0.idOrdenEmbarque
			AND idMarca = T0.idMarca ) as piezasLeidas
		FROM cmiDetalleOrdenEmbarque T0
		INNER JOIN cmiOrdenesEmbarque T1 ON T1.idOrdenEmbarque = T0.idOrdenEmbarque 
									AND T1.estatusOrdenEmbarque = 1
		INNER JOIN cmiProyectos T2 ON T2.idProyecto = T1.idProyecto 
		INNER JOIN cmiEtapas T3 ON T3.idEtapa= T1.idEtapa
		INNER JOIN cmiPlanosMontaje T4 ON T4.idEtapa = T1.idEtapa
		INNER JOIN cmiPlanosDespiece T5 ON T4.idPlanoMontaje = T5.idPlanoMontaje
		INNER JOIN cmiMarcas T6 ON T6.idPlanoDespiece = T5.idPlanoDespiece
								AND T6.idMarca = T0.idMarca
		WHERE T0.idOrdenEmbarque = @idOrdenEmbarque
		GROUP BY T0.idOrdenEmbarque,T0.idMarca,
		T6.codigoMarca, T6.pesoMarca, T2.nombreProyecto, 
		T3.claveEtapa, T4.codigoPlanoMontaje;
	END
	ELSE
	BEGIN
		SELECT 'La Orden de embarca no se ha embarcado en su totalidad.' Mensaje
	END

END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleOrdenProduccion]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------
CREATE PROCEDURE [dbo].[usp_CargarDetalleOrdenProduccion]
	@idEtapa int,
	@idEstatusEtapa int,
	@idEstatus int,
	@clase char(1)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 21/Marzo/16
-- Descripcion: Se carga el detalle completo de la
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @sCadenaBusqueda VARCHAR(200)

	IF @clase = 'T'
		SET @sCadenaBusqueda = '%';
	ELSE
		SET @sCadenaBusqueda = 	'%' + @clase + '%';

	SELECT CONCAT(P.codigoProyecto,' - ',E.nombreEtapa) AS seccion
		  ,C.nombreCategoria AS tipo
		  ,M.idMarca AS pieza
		  ,M.nombreMarca AS marca
		  ,RIGHT('00' + RTRIM(S.idSerie), 2) AS serie
		  ,SM.codigoSubMarca AS submarca
		  ,SM.perfilSubMarca AS perfil
		  ,SM.piezasSubMarca AS piezas
		  ,SM.corteSubMarca AS numCorte
		  ,SM.longitudSubMarca AS longitud
		  ,SM.anchoSubMarca AS ancho
		  ,SM.gradoSubMarca AS grado
		  ,SM.kgmSubMarca AS kgm
		  ,SM.totalLASubMarca AS totalLA
		  ,SM.totalSubMarca AS total
		  ,PD.codigoPlanoDespiece AS numPlano
		  ,(SM.kgmSubMarca * SM.totalLASubMarca) AS peso
	FROM cmiSubMarcas SM
	INNER JOIN cmiMarcas M ON M.idMarca = SM.idMarca
	INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	INNER JOIN cmiProyectos P ON E.idProyecto = P.idProyecto
	INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
	INNER JOIN cmiSeries S ON S.idMarca = M.idMarca
	WHERE E.idEtapa = @idEtapa 
		AND E.estatusEtapa = ISNULL(@idEstatusEtapa,10)
		AND E.idEstatus = ISNULL(@idEstatus,1)
		AND PM.idEstatus = 1
		AND PD.idEstatus = 1
		AND M.idEstatus = 1
		AND SM.idEstatus = 1
		AND SM.claseSubMarca LIKE @sCadenaBusqueda
		-- Condicion que siempre se debe cumplir
		-- pero no esta de mas agregarla.
		AND SM.idOrdenProduccion = E.idEtapa
	ORDER BY seccion, tipo, pieza, marca, serie, submarca
END
----------------------




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleReqManual]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarDetalleReqManual]
	@item int,
	@idRequerimiento int,
	@Estatus int,
	@idRequisicion int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 01/Marzo/16
-- Descripcion: Se cargan las Marcas de un Plano Despiece 
-- Parametros de salida:
-- Parametros de entrada:  @idRequerimiento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
		SELECT T1.idDetalleRequisicion,T2.idMaterial, T2.nombreMaterial,T2.calidadMaterial, T2.anchoMaterial, T2.largoMaterial,
				T1.cantidadSolicitada,T2.pesoMaterial, T4.idUnidadMedida, T4.nombreCortoUnidadMedida, T5.idAlmacen
		FROM cmiRequisiciones T0
			INNER JOIN cmiDetallesRequisicion T1 ON T0.idRequisicion = T1.idRequisicion
			INNER JOIN cmiMateriales T2 ON T1.idMaterial = T2.idMaterial
			INNER JOIN cmiRequerimientos T3 ON T0.idRequerimiento = T3.idRequerimiento
			INNER JOIN cmiUnidadesMedida T4 ON T1.idUnidadMedida = T4.idUnidadMedida
			INNER JOIN cmiAlmacenes T5 ON T0.idAlmacen = T5.idAlmacen
		WHERE t3.idRequerimiento = @idRequerimiento
		and t1.idDetalleRequisicion = ISNULL(@item, t1.idDetalleRequisicion)
			and t0.idEstatus = ISNULL(@Estatus,t0.idEstatus)
			and t0.idRequisicion = ISNULL(@idRequisicion,t0.idRequisicion)
		
END
----------------------


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDocumentos]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarDocumentos]
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Abril/16
-- Descripcion: Se cargan los movimeintos de materiales
-- Parametros de salida:
-- Parametros de entrada:  
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select distinct documentoMovimientoMaterial  from cmiMovimientosMaterial 
order by documentoMovimientoMaterial 


		
END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarDocumentosMaterialesProyecto]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarDocumentosMaterialesProyecto]
  @idProyecto INT
 ,@idEtapa INT
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga los documetos generados de materiales asignados
-- Parametros de salida:
-- Parametros de entrada:  
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select distinct documentoMaterialProyecto  from cmiMaterialesProyecto 
	where idProyecto = @idProyecto
	and idEtapa = @idEtapa
	order by documentoMaterialProyecto

END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarEtapas]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarEtapas]
	@idProyecto int,
	@revisionProyecto char(3),
	@idEtapa int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 18/Febrero/16
-- Descripcion: Se cargan las Etapas de un Proyecto 
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto,@revisionProyecto,@idEtapa,@idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idEtapa]
		  ,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
		  ,T0.[idProyecto]
		  ,T0.[nombreEtapa]
		  ,T0.[estatusEtapa]
		  ,convert(varchar(10), T0.[fechaInicioEtapa], 103)  fechaInicioEtapa
		  ,convert(varchar(10), T0.[fechaFinEtapa], 103)  fechaFinEtapa
		  ,T0.[infGeneralEtapa]
		  ,T0.[usuarioCreacion]
		  ,T0.[revisionProyecto]
		  ,T0.[claveEtapa]
		  ,T1.[nombreEstatus]
	  FROM [cmiEtapas] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[estatusEtapa]
  WHERE T0.[idEtapa] = ISNULL(@idEtapa,T0.[idEtapa])
  AND T0.[idProyecto] = ISNULL(@idProyecto,T0.[idProyecto])
  AND T0.[estatusEtapa] = ISNULL(@idStatus,T0.[estatusEtapa])
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarExistenciaPlaDes]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarExistenciaPlaDes]
	@codigosPlanoDespiece varchar(max),
	@idEtapa int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 20/Febrero/16
-- Descripcion: Se cargan los Planos Despiede de un Plano Montaje 
-- Parametros de salida:
-- Parametros de entrada:  @codigosPlanoDespiece,@idEtapa
******************************************
*/
DECLARE @planosDespiece xml

BEGIN
	
	SET @planosDespiece = @codigosPlanoDespiece;
	
	SELECT T0.idPlanoDespiece,T0.codigoPlanoDespiece, 
		   T1.nombreTipoConstruccion, T1.idTipoConstruccion
	FROM cmiPlanosDespiece T0 
	INNER JOIN cmiTiposConstruccion T1 ON T1.idTipoConstruccion = T0.idTipoConstruccion
	INNER JOIN cmiPlanosMontaje T2 ON T2.idPlanoMontaje = T0.idPlanoMontaje
									AND T2.idEtapa = @idEtapa
	WHERE codigoPlanoDespiece in (SELECT ParamValues.ID.value('.','VARCHAR(50)')
								  FROM @planosDespiece.nodes('id') AS ParamValues(ID))

END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarExistencias]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarExistencias]
	@idMaterial int,
	@idMaterialA int,
	@idAlmacen int,
	@idAlmacenA int,
	@idGrupo int,
	@idGrupoA int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan el REPORTE DE EXISTENCIAS
-- Parametros de salida:
-- Parametros de entrada:  
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select  ROW_NUMBER() over(order by t0.idMaterial) rank,t4.nombreGrupo,t0.idMaterial,t1.nombreMaterial, t1.anchoMaterial, t2.nombreCortoUnidadMedida nombreCortoUnidadMedidaAncho, t1.largoMaterial, t3.nombreCortoUnidadMedida nombreCortoUnidadMedidaLargo, t1.calidadMaterial, t0.cantidadInventario from 
	cmiInventarios t0 
	inner join cmiMateriales t1 on t0.idMaterial = t1.idMaterial and
									t1.idGrupo between isnull(@idGrupo,t1.idGrupo) and isnull(@idGrupoA,t1.idGrupo)
	inner join cmiUnidadesMedida t2 on t1.idUMAncho = t2.idUnidadMedida
	inner join cmiUnidadesMedida t3 on t1.idUMLargo = t3.idUnidadMedida
	inner join cmiGrupos t4 on t1.idGrupo = t4.idGrupo 
	where t0.idMaterial between isnull(@idMaterial,t0.idMaterial) and isnull(@idMaterialA,t0.idMaterial)
	and t0.idAlmacen between isnull(@idAlmacen,t0.idAlmacen) and isnull(@idAlmacenA,t0.idAlmacen)

END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarGrupos]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarGrupos]
	@IdGrupo int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Grupos
-- Parametros de salida:
-- Parametros de entrada:  @IdGrupo @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiGrupos].[idGrupo]
			,[dbo].[cmiGrupos].[fechaCreacion]
			,[dbo].[cmiGrupos].[fechaUltModificacion]
			,[dbo].[cmiGrupos].[usuarioCreacion]
			,[dbo].[cmiGrupos].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiGrupos].[nombreGrupo]
	FROM [dbo].[cmiGrupos]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiGrupos].[idEstatus]
	WHERE [dbo].[cmiGrupos].[idGrupo] = ISNULL(@IdGrupo, [dbo].[cmiGrupos].[idGrupo]) 
		AND [dbo].[cmiGrupos].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiGrupos].[idEstatus])

		
END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarHeaderMaterialesProyecto]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarHeaderMaterialesProyecto]
	@idProyecto int,
	@idEtapa int,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Abril/16
-- Descripcion: Se cargan el header de materiales asignados al proyecto
-- Parametros de salida:
-- Parametros de entrada: @idProyecto @idEtapa @idDocumento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select distinct documentoMaterialProyecto, et.idEtapa, et.nombreEtapa, mp.idProyecto ,  pr.nombreProyecto, us.nombreUsuario 
from cmiMaterialesProyecto  mp
inner join cmiEtapas et on et.idEtapa = mp.idEtapa 
inner join cmiProyectos pr on pr.idProyecto = mp.idProyecto
inner join cmiUsuarios us on us.idUsuario = mp.usuarioCreacion  
where mp.idProyecto = @idProyecto
and mp.idEtapa = @idEtapa
and mp.documentoMaterialProyecto = @idDocumento 


END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarHeaderMovtosMaterial]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarHeaderMovtosMaterial]
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Abril/16
-- Descripcion: Se cargan los movimeintos de materiales
-- Parametros de salida:
-- Parametros de entrada:  @idDocumento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

select documentoMovimientoMaterial, tm.nombreTipoMovtoMaterial 
from cmiMovimientosMaterial ma
INNER JOIN cmiTiposMovtoMaterial tm ON ma.idTipoMovtoMaterial = tm.idTipoMovtoMaterial 
where documentoMovimientoMaterial = ISNULL(@idDocumento,documentoMovimientoMaterial)
GROUP BY documentoMovimientoMaterial, tm.nombreTipoMovtoMaterial 


END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarHeaderOrdenEmbarque]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarHeaderOrdenEmbarque]
	@idProyecto int,	
	@idEtapa int,
	@idOrden int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan las ordenes de embarque
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select CONVERT(varchar(255), et.nombreEtapa) + ' - ETAPA ' + CONVERT(varchar(255), et.idEtapa) Etapa,
		pr.codigoProyecto, pr.revisionProyecto, oe.idOrdenEmbarque, pr.nombreProyecto
		from cmiOrdenesEmbarque oe
		inner join cmiProyectos pr on oe.idProyecto = pr.idProyecto 
		inner join cmiEtapas et on oe.idEtapa = et.idEtapa 
		where pr.idProyecto = @idProyecto
		and et.idEtapa = @idEtapa
		and oe.idOrdenEmbarque = @idOrden
	  
		
END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarKardex]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarKardex]
	@idMaterial int,	
	@idAlmacen int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan el kardex
-- Parametros de salida:
-- Parametros de entrada:  @idMaterial @idAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select ROW_NUMBER() over(order by ka.idMaterial, ka.fechaCreacion) rank, gr.nombreGrupo, ka.idMaterial,ma.nombreMaterial, al.nombreAlmacen  , ka.documentoKardex, tm.nombreTipoMovtoMaterial, 
	tm.tipoMovtoMaterial, case when tipoMovtoMaterial = 'S' then - ka.cantidadKardex else ka.cantidadKardex end cantidadKardex, ka.fechaCreacion, ma.anchoMaterial, ma.largoMaterial 
	, inv.cantidadInventario from cmiKardex ka
	inner join cmiMateriales ma on ka.idMaterial = ma.idMaterial 
	inner join cmiAlmacenes al on ka.idAlmacen = al.idAlmacen 
	inner join cmiTiposMovtoMaterial tm on ka.idTipoMovtoMaterial = tm.idTipoMovtoMaterial
	inner join cmiGrupos gr on ma.idGrupo = gr.idGrupo 
	inner join cmiInventarios inv on ka.idMaterial = inv.idMaterial and ka.idAlmacen = inv.idAlmacen 
	where ka.idMaterial = ISNULL(@idMaterial,ka.idMaterial)
	and ka.idAlmacen = ISNULL(@idAlmacen, ka.idAlmacen)
	order by ka.idMaterial, ka.fechaCreacion asc
	  
		
END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarLGPDetalle]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarLGPDetalle]
	@idEtapa int,
	@idUsuario int	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 31/Marzo/16
-- Descripcion: Se carga la informacion para los reportes LGPDetalle
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT  T1.codigoPlanoMontaje, T2.codigoPlanoDespiece,T3.codigoMarca,T3.piezasMarca,
			T4.[codigoSubMarca],T4.[perfilSubMarca],T4.[piezasSubMarca],T4.[corteSubMarca],
			T4.[longitudSubMarca],T4.[anchoSubMarca],T4.[gradoSubMarca],T4.[kgmSubMarca],
			T4.[totalLASubMarca],T4.[pesoSubMarca],T4.[totalSubMarca],T5.nombreTipoConstruccion
	FROM cmiEtapas T0
	INNER JOIN cmiPlanosMontaje T1 ON T1.idEtapa = T0.idEtapa AND T1.idEstatus= 1
	INNER JOIN cmiPlanosDespiece T2 ON T2.idPlanoMontaje = T1.idPlanoMontaje AND T2.idEstatus= 1
	INNER JOIN cmiTiposConstruccion T5 ON T5.idTipoConstruccion = T2.idTipoConstruccion
	INNER JOIN cmiMarcas T3 ON T3.idPlanoDespiece = T2.idPlanoDespiece AND T3.idEstatus= 1
	INNER JOIN cmiSubMarcas T4 ON T4.idMarca = T3.idMarca AND T4.idEstatus= 1
	WHERE T0.idEtapa = @idEtapa
	
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarLGPResumen]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarLGPResumen]
	@idEtapa int,
	@idUsuario int	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 04/Abril/16
-- Descripcion: Se carga la informacion para los reportes LGPResumen
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT  T1.codigoPlanoMontaje, T2.codigoPlanoDespiece,T3.codigoMarca,T3.piezasMarca,
			 T5.nombreTipoConstruccion, sum(T4.[pesoSubMarca]) as pesoMarca
	FROM cmiEtapas T0
	INNER JOIN cmiPlanosMontaje T1 ON T1.idEtapa = T0.idEtapa AND T1.idEstatus= 1
	INNER JOIN cmiPlanosDespiece T2 ON T2.idPlanoMontaje = T1.idPlanoMontaje AND T2.idEstatus= 1
	INNER JOIN cmiTiposConstruccion T5 ON T5.idTipoConstruccion = T2.idTipoConstruccion
	INNER JOIN cmiMarcas T3 ON T3.idPlanoDespiece = T2.idPlanoDespiece AND T3.idEstatus= 1
	INNER JOIN cmiSubMarcas T4 ON T4.idMarca = T3.idMarca AND T4.idEstatus= 1
	WHERE T0.idEtapa = @idEtapa
	GROUP BY T1.codigoPlanoMontaje, T2.codigoPlanoDespiece,T3.codigoMarca,T3.piezasMarca,
			 T5.nombreTipoConstruccion
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMarcas]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarMarcas]
	@idPlanoDespiece int,	
	@idMarca int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 01/Marzo/16
-- Descripcion: Se cargan las Marcas de un Plano Despiece 
-- Parametros de salida:
-- Parametros de entrada:  @idPlanoDespiece,@idMarca, @idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idPlanoDespiece]
		  ,T0.[idMarca]
		  ,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
		  ,T0.[codigoMarca]
		  ,T0.[nombreMarca]
		  ,T0.[idEstatus]		  
		  ,T0.[usuarioCreacion]
		  ,T0.[pesoMarca]
		  ,T0.[piezasMarca]
		  ,T1.[nombreEstatus]		  
	  FROM [cmiMarcas] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]  
  WHERE T0.[idPlanoDespiece] = ISNULL(@idPlanoDespiece,T0.[idPlanoDespiece])
  AND T0.[idMarca] = ISNULL(@idMarca,T0.[idMarca])  
  AND T0.[idEstatus] = ISNULL(@idStatus,T0.[idEstatus])
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMarcasDispoOrdenEmb]    Script Date: 01/07/2016 01:19:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMarcasDispoOrdenEmb]
	@idProyecto int,	
	@idEtapa int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Abril/16
-- Descripcion: Se cargan las marcas disponibles  
				ha ser embarcadas. que no existan en una orden de embarque
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa
******************************************
*/
DECLARE @IdProcesoFinal INT
BEGIN

	SET NOCOUNT ON;

	SELECT @IdProcesoFinal = RF.idProceso
	FROM cmiProyectos P
	INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
	WHERE P.idProyecto = @idProyecto
		AND RF.secuenciaRutaFabricacion = (SELECT MAX(secuenciaRutaFabricacion)
											FROM cmiRutasFabricacion RF2
											WHERE RF2.idCategoria = P.idCategoria);

	select se.idMarca, se.idSerie, mar.nombreMarca, 
		   mar.piezasMarca, mar.pesoMarca,pm.nombrePlanoMontaje 
	from cmiEtapas et 
		inner join cmiProyectos pr on et.idProyecto = pr.idProyecto 
		inner join cmiPlanosMontaje pm on et.idEtapa = pm.idEtapa 
		inner join cmiPlanosDespiece pd on pm.idPlanoMontaje = pd.idPlanoMontaje 
		inner join cmiMarcas mar on pd.idPlanoDespiece = mar.idPlanoDespiece 
		inner join cmiSeries se on mar.idMarca = se.idMarca 
	where pr.idProyecto = @idProyecto
		and et.idEtapa = @idEtapa
		and se.idProcesoActual = @IdProcesoFinal
		and se.idMarca + se.idSerie not in (select idMarca + idSerie as MarcaSerie
											from cmiDetalleOrdenEmbarque)

END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMarcasOrdenEmb]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMarcasOrdenEmb]
	@idProyecto int,	
	@idEtapa int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan las marcas
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa
******************************************
*/
DECLARE @IdProcesoFinal INT
BEGIN

	SET NOCOUNT ON;

	SELECT @IdProcesoFinal = RF.idProceso
	FROM cmiProyectos P
	INNER JOIN cmiRutasFabricacion RF ON RF.idCategoria = P.idCategoria
	WHERE P.idProyecto = @idProyecto
		AND RF.secuenciaRutaFabricacion = (SELECT MAX(secuenciaRutaFabricacion)
											FROM cmiRutasFabricacion RF2
											WHERE RF2.idCategoria = P.idCategoria);

	select se.idMarca, se.idSerie, pr.nombreProyecto, et.idEtapa, mar.nombreMarca, 
		   mar.piezasMarca, mar.pesoMarca, (mar.pesoMarca * mar.piezasMarca) Total,
		   pm.nombrePlanoMontaje 
	from cmiEtapas et 
		inner join cmiProyectos pr on et.idProyecto = pr.idProyecto 
		inner join cmiPlanosMontaje pm on et.idEtapa = pm.idEtapa 
		inner join cmiPlanosDespiece pd on pm.idPlanoMontaje = pd.idPlanoMontaje 
		inner join cmiMarcas mar on pd.idPlanoDespiece = mar.idPlanoDespiece 
		inner join cmiSeries se on mar.idMarca = se.idMarca 
	where pr.idProyecto = @idProyecto
		and et.idEtapa = @idEtapa
		and se.idProcesoActual = @IdProcesoFinal

END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMateriales]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMateriales]
	@idMaterial int,
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Materiales 
-- Parametros de salida:
-- Parametros de entrada:  @idMaterial, @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
SELECT [idMaterial]
		  ,ma.[fechaCreacion]
		  ,ma.[idEstatus]
		  ,[nombreEstatus]
		  ,[nombreMaterial]
		  ,[anchoMaterial]
		  ,um.idUnidadMedida  [idUMAncho]
		  ,um.nombreCortoUnidadMedida [NomUMAncho]
		  ,[largoMaterial]
		  ,um2.idUnidadMedida [idUMLargo]
		  ,um2.nombreCortoUnidadMedida [NomUMLargo]
		  ,[pesoMaterial]
		  ,um3.idUnidadMedida [idUMPeso]
		  ,um3.nombreCortoUnidadMedida [NomUMPeso]
		  ,[calidadMaterial]
		  ,tm.idTipoMaterial [idTipoMaterial]
		  ,tm.nombreTipoMaterial [nombreTipoMaterial]
		  ,gr.idGrupo [idGrupo]
		  ,gr.nombreGrupo [nombreGrupo]
		  ,[observacionesMaterial]
		  ,ma.[usuarioCreacion]
  FROM [cmiMateriales] as ma
	inner join cmiUnidadesMedida um on ma.idUMLargo = um.idUnidadMedida
	inner join cmiUnidadesMedida um2 on ma.idUMAncho = um2.idUnidadMedida
	inner join cmiUnidadesMedida um3 on ma.idUMPeso = um3.idUnidadMedida
	inner join cmiTiposMaterial tm on ma.idTipoMaterial = tm.idTipoMaterial
	inner join cmiGrupos as gr on ma.idGrupo = gr.idGrupo
	inner join cmiEstatus as es on ma.idEstatus = es.idEstatus
   WHERE [idMaterial] = ISNULL(@idMaterial,[idMaterial])
	 and ma.[idEstatus] = ISNULL(@idEstatus,ma.[idEstatus])	
	  
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMaterialesAsignados]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMaterialesAsignados]
	@idProyecto int,	
	@idEtapa int,
	@idRequerimiento int,
	@idAlmacen int,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga el detalle de materiales asignados a un proyecto etapa
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idRequerimiento @idAlmacen @idDocumento
******************************************
*/
DECLARE @VALIDA INT, @SQL VARCHAR(100)
BEGIN
	
	SET NOCOUNT ON;

	SELECT @VALIDA = COUNT(*) 
	FROM cmiInventarios 
	WHERE idAlmacen = @idAlmacen;

	IF @VALIDA = 0 
	BEGIN
		SET @idAlmacen = NULL;
	END
	
	SELECT mp.idMaterialProyecto, mp.idMaterial, ma.nombreMaterial, um.nombreCortoUnidadMedida, inv.cantidadInventario,
		0 cantidadEntrega,	ma.calidadMaterial, ma.anchoMaterial, ma.largoMaterial, ma.largoMaterial * 0.3048 LongArea, ma.pesoMaterial,
		(mp.cantidadMaterialProyecto * (ma.largoMaterial * 0.3048) * ma.pesoMaterial) Total
	FROM cmiMaterialesProyecto mp
	INNER JOIN cmiMateriales ma ON mp.idMaterial = ma.idMaterial
	INNER JOIN cmiUnidadesMedida um ON mp.idUnidadMedida = um.idUnidadMedida 
	LEFT OUTER JOIN cmiInventarios inv on mp.idMaterial = inv.idMaterial
									AND inv.idAlmacen = ISNULL(@idAlmacen,inv.idAlmacen)
	WHERE mp.idProyecto = @idProyecto
	AND mp.idEtapa = @idEtapa
	AND mp.documentoMaterialProyecto  = @idDocumento;

END
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMaterialesProyecto]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMaterialesProyecto]
	@idProyecto int,	
	@idEtapa int,
	@idMatPro int,
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga el detalle de materiales asignados a un proyecto etapa
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idMatPro @idDocumento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select idMaterialProyecto, mp.idMaterial, ma.nombreMaterial, um.nombreCortoUnidadMedida, case when inv.cantidadInventario is null then 0 else inv.cantidadInventario end as cantidadInventario ,
		CASE WHEN mp.cantidadMaterialProyecto IS NULL THEN 0 ELSE mp.cantidadMaterialProyecto END AS cantidadEntrega,
		ma.calidadMaterial, ma.anchoMaterial, ma.largoMaterial, ma.largoMaterial * 0.3048 LongArea, ma.pesoMaterial,
		(mp.cantidadMaterialProyecto * (ma.largoMaterial * 0.3048) * ma.pesoMaterial) Total, mp.idAlmacen
	from cmiMaterialesProyecto mp
		INNER JOIN cmiMateriales ma ON mp.idMaterial = ma.idMaterial 
		INNER JOIN cmiUnidadesMedida um ON mp.idUnidadMedida = um.idUnidadMedida
		LEFT OUTER JOIN cmiInventarios inv ON inv.idMaterial = mp.idMaterial and inv.idAlmacen = mp.idAlmacen
	where mp.idEtapa = @idEtapa
	and mp.idProyecto = @idProyecto
	and mp.idMaterialProyecto = ISNULL(@idMatPro, mp.idMaterialProyecto)
	and mp.documentoMaterialProyecto = @idDocumento


END
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarModulosSeguridad]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarModulosSeguridad]	
	@idUsuario int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 01/Febrero/16
-- Descripcion: Se cargan los Modulos del sistema
-- Parametros de salida:
-- Parametros de entrada:  
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT T0.[idModulo]
		  ,T0.[idEstatus]
		  ,T0.[nombreModulo]
		  ,T1.[lecturaPermiso]
		  ,T1.[escrituraPermiso]
		  ,T1.[borradoPermiso]
		  ,T1.[clonadoPermiso]
	  FROM [cmiModulos] T0 
	  LEFT JOIN [cmiPermisos] T1 ON   T0.idModulo = T1.idModulo And
									  T1.idUsuario = @idUsuario and
									  T1.idEstatus = 1
	  WHERE T0.idEstatus = 1
	  ORDER BY T0.[idModulo]
	 	 
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarMovimientosMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarMovimientosMaterial]
	@idDocumento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Abril/16
-- Descripcion: Se cargan los movimeintos de materiales
-- Parametros de salida:
-- Parametros de entrada:  @idDocumento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idMovimientoMaterial, mm.idMaterial, ma.nombreMaterial, documentoMovimientoMaterial, 
			inv.cantidadInventario, cantidadMovimientoMaterial, tm.tipoMovtoMaterial, al.nombreAlmacen, ma.calidadMaterial,
			ma.largoMaterial , ma.anchoMaterial 
	FROM cmiMovimientosMaterial mm
	INNER JOIN cmiMateriales ma ON mm.idMaterial = ma.idMaterial 
	INNER JOIN cmiAlmacenes al ON mm.idAlmacen = al.idAlmacen 
	INNER JOIN cmiInventarios inv ON mm.idMaterial = inv.idMaterial  AND mm.idAlmacen = inv.idAlmacen 
	INNER JOIN cmiTiposMovtoMaterial tm ON mm.idTipoMovtoMaterial = tm.idTipoMovtoMaterial
	WHERE mm.documentoMovimientoMaterial = ISNULL(@idDocumento, mm.documentoMovimientoMaterial)
	ORDER BY mm.idMaterial


		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarOERemision]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarOERemision]
	@idProyecto int	,
	@idEtapa int,
	@idEstatus int,
	@sinRemision char(4)
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 20/Abril/16
-- Descripcion: Se cargan las Ordenes de Embarque para darle seguimiento Tablet1 y Tablet2
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto,@idEtapa,@idEstatus,@sinRemision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	if @sinRemision = 'true'
	begin
		SELECT	T0.[idOrdenEmbarque]
				,T0.[idOrdenProduccion]
				,T0.[observacionOrdenEmbarque]
				,T0.[estatusOrdenEmbarque]
				,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
		FROM cmiOrdenesEmbarque T0 		
		WHERE T0.idProyecto  = ISNULL(@idProyecto,T0.[idProyecto])
		and T0.idEtapa = ISNULL(@idEtapa,T0.idEtapa)
		and T0.estatusOrdenEmbarque = ISNULL(@idEstatus,T0.[estatusOrdenEmbarque])
		and T0.idOrdenEmbarque not in (select idOrdenEmbarque from cmiRemisionDetalle );
	end
	else
	begin
		SELECT	T0.[idOrdenEmbarque]
				,T0.[idOrdenProduccion]
				,T0.[observacionOrdenEmbarque]
				,T0.[estatusOrdenEmbarque]
				,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
		FROM cmiOrdenesEmbarque T0
		WHERE T0.idProyecto  = ISNULL(@idProyecto,T0.[idProyecto])
		and T0.idEtapa = ISNULL(@idEtapa,T0.idEtapa)
		and T0.estatusOrdenEmbarque = ISNULL(@idEstatus,T0.[estatusOrdenEmbarque]);
	end

END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarOrdenEmbarque]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarOrdenEmbarque]
	@idOrdenEmbarque int	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 30/Abril/16
-- Descripcion: Se carga la Orden de embarque
-- Parametros de salida:
-- Parametros de entrada:  @idOrdenEmbarque
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	T0.[idOrdenProduccion]
			,T0.[observacionOrdenEmbarque]
			,T0.[estatusOrdenEmbarque]
			,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
			,T1.idMarca
			,T1.idSerie
			,T2.nombreMarca
			,T2.pesoMarca
			,T2.piezasMarca
			,T4.nombrePlanoMontaje
	FROM cmiOrdenesEmbarque T0 
	INNER JOIN cmiDetalleOrdenEmbarque T1 ON T0.idOrdenEmbarque = T1.idOrdenEmbarque
	INNER JOIN cmiMarcas T2 ON T2.idMarca = T1.idMarca
	INNER JOIN cmiPlanosDespiece T3 ON T3.idPlanoDespiece = T2.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje T4 ON T4.idPlanoMontaje = T3.idPlanoMontaje
	WHERE  T0.idOrdenEmbarque = @idOrdenEmbarque;

END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarOrdenProduccion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarOrdenProduccion]
	@idEtapa int,
	@claseSubMarca char(1)	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 31/Marzo/16
-- Descripcion: Se cargan las ordenes de produccion 
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa @claseSubMarca
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT  T1.codigoPlanoMontaje, T2.codigoPlanoDespiece,T3.codigoMarca,T3.piezasMarca,
			T4.[codigoSubMarca],T4.[perfilSubMarca],T4.[piezasSubMarca],T4.[corteSubMarca],
			T4.[longitudSubMarca],T4.[anchoSubMarca],T4.[gradoSubMarca],T4.[kgmSubMarca],
			T4.[totalLASubMarca],T4.[pesoSubMarca],T4.[totalSubMarca]
	FROM cmiEtapas T0
	INNER JOIN cmiPlanosMontaje T1 ON T1.idEtapa = T0.idEtapa AND T1.idEstatus= 1
	INNER JOIN cmiPlanosDespiece T2 ON T2.idPlanoMontaje = T1.idPlanoMontaje AND T2.idEstatus= 1
	INNER JOIN cmiMarcas T3 ON T3.idPlanoDespiece = T2.idPlanoDespiece AND T3.idEstatus= 1
	INNER JOIN cmiSubMarcas T4 ON T4.idMarca = T3.idMarca AND T4.idEstatus= 1
	WHERE T0.idEtapa = @idEtapa
	AND T4.claseSubMarca = @claseSubMarca
	  
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarOrigenReq]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarOrigenReq]
	@idOrigenRequisicion int,	
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan las origenes de requisicion
-- Parametros de salida:
-- Parametros de entrada:  @idOrigenRequisicion @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idOrigenRequisicion
				,ori.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,ori.idEstatus
				,nombreEstatus
				,nombreOrigenRequisicion	 
	  FROM  cmiOrigenesRequisicion as ori
	  inner join cmiEstatus as es on ori.idEstatus = es.idEstatus
	  where idOrigenRequisicion = ISNULL(@idOrigenRequisicion,idOrigenRequisicion)
	  and ori.idEstatus = ISNULL(@idEstatus,ori.idEstatus)
	  
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarPlanosDespiece]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarPlanosDespiece]
	@idPlanoMontaje int,	
	@idPlanoDespiece int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 20/Febrero/16
-- Descripcion: Se cargan los Planos Despiede de un Plano Montaje 
-- Parametros de salida:
-- Parametros de entrada:  @idPlanoMontaje,@idPlanoDespiece,@idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idPlanoDespiece]
		  ,T0.[idPlanoMontaje]
		  ,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
		  ,T0.[codigoPlanoDespiece]
		  ,T0.[nombrePlanoDespiece]
		  ,T0.[idEstatus]		  
		  ,T0.[infGeneralPlanoDespiece]
		  ,T0.[archivoPlanoDespiece]
		  ,T0.[usuarioCreacion]
		  ,T0.[idTipoConstruccion]
		  ,T1.[nombreEstatus]
		  ,T2.[nombreTipoConstruccion]
	  FROM [cmiPlanosDespiece] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
  INNER JOIN [dbo].[cmiTiposConstruccion] T2 ON T2.[idTipoConstruccion] = T0.[idTipoConstruccion]
  WHERE T0.[idPlanoDespiece] = ISNULL(@idPlanoDespiece,T0.[idPlanoDespiece])
  AND T0.[idPlanoMontaje] = ISNULL(@idPlanoMontaje,T0.[idPlanoMontaje])  
  AND T0.[idEstatus] = ISNULL(@idStatus,T0.[idEstatus])
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarPlanosMontaje]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarPlanosMontaje]
	@idEtapa int,	
	@idPlanoMontaje int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 20/Febrero/16
-- Descripcion: Se cargan los Planos Montaje de una Etapa 
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa,@idPlanoMontaje,@idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idPlanoMontaje]
		  ,T0.[idEtapa]
		  ,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
		  ,T0.[codigoPlanoMontaje]
		  ,T0.[nombrePlanoMontaje]
		  ,T0.[idEstatus]
		  ,convert(varchar(10), T0.[fechaInicioPlanoMontaje], 103)  fechaInicioPlanoMontaje
		  ,convert(varchar(10), T0.[fechaFinPlanoMontaje], 103)  fechaFinPlanoMontaje
		  ,T0.[infGeneralPlanoMontaje]
		  ,T0.[archivoPlanoMontaje]
		  ,T0.[usuarioCreacion]
		  ,T1.[nombreEstatus]
	  FROM [cmiPlanosMontaje] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
  WHERE T0.[idPlanoMontaje] = ISNULL(@idPlanoMontaje,T0.[idPlanoMontaje])
  AND T0.[idEtapa] = ISNULL(@idEtapa,T0.[idEtapa])  
  AND T0.[idEstatus] = ISNULL(@idStatus,T0.[idEstatus])
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarProcesoAvanceProduccion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CargarProcesoAvanceProduccion]
	@IdProyecto int,
	@IdUsuario int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 25/Marzo/16
-- Descripcion: Se cargan los Procesos
-- Parametros de salida:
-- Parametros de entrada:  @IdProyecto, @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT ISNULL(U.idProcesoOrigen,0) AS idProceso
	      ,P.nombreProceso
		  ,P.idTipoProceso
		  ,TP.nombreTipoProceso
	FROM cmiUsuarios U
	INNER JOIN cmiProcesos P ON U.idProcesoOrigen = P.idProceso
	INNER JOIN cmiTiposProceso TP ON TP.idTipoProceso = P.idTipoProceso
	INNER JOIN cmiRutasFabricacion RF ON U.idProcesoOrigen = RF.idProceso
	INNER JOIN cmiProyectos PR ON PR.idCategoria = RF.idCategoria
	WHERE PR.idProyecto = @IdProyecto AND U.idUsuario = @IdUsuario
	
END






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarProcesos]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CargarProcesos]
	@IdProceso int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 10/Febrero/16
-- Descripcion: Se cargan los Almacenes
-- Parametros de salida:
-- Parametros de entrada:  @IdProceso @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 P.idProceso
			,P.fechaCreacion
			,P.fechaUltModificacion
			,P.usuarioCreacion
			,P.idEstatus
			,E.nombreEstatus
			,P.nombreProceso
			,P.idTipoProceso
			,P.claseAvance
			,TP.nombreTipoProceso
	FROM cmiProcesos P
	INNER JOIN cmiEstatus E ON E.idEstatus = P.idEstatus
	INNER JOIN cmiTiposProceso TP ON TP.idTipoProceso = P.idTipoProceso
	WHERE P.idProceso = ISNULL(@IdProceso, P.idProceso)
		AND P.idEstatus = ISNULL(@IdEstatus, P.idEstatus)
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarProyectos]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarProyectos]
	@idProyecto int	,
	@revisionProyecto char(3),
	@idEstatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Se cargan los Proyectos 
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto, @revisionProyecto
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idProyecto]
      ,T0.[revisionProyecto]
      ,T0.[codigoProyecto]
      ,T0.[nombreProyecto]
      ,T0.[estatusProyecto]
      ,T0.[idCategoria]
      ,T0.[idCliente]
      ,T0.[archivoPlanoProyecto]
      ,T0.[infGeneralProyecto]
      ,T0.[estatusProyecto]
      ,convert(varchar(10), T0.[fechaInicioProyecto], 103)  fechaInicioProyecto
      ,convert(varchar(10), T0.[fechaFinProyecto], 103) fechaFinProyecto
      ,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
      ,convert(varchar(10), T0.[fechaRevision], 103)  fechaRevision
      ,T0.[idEstatusRevision]
      ,T1.[nombreEstatus]
      ,T2.[contactoCliente] contactoCliente
      ,T2.[nombreCliente] nombreCliente
      ,T2.[direccionEntregaCliente] direccionCliente
	  ,T0.idEstatusRevision
  FROM [cmiProyectos] T0
  INNER JOIN [cmiEstatus] T1 ON T1.[idEstatus] = T0.[estatusProyecto]
  INNER JOIN [cmiClientes] T2 ON T2.[idCliente] = T0.[idCliente]
  WHERE T0.[idProyecto] = ISNULL(@idProyecto,T0.[idProyecto])
  AND  T0.[revisionProyecto]= ISNULL(@revisionProyecto,T0.[revisionProyecto])
  AND  T0.[estatusProyecto] = ISNULL(@idEstatus, T0.[estatusProyecto])
  

END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRecepcionCompra]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarRecepcionCompra]
	@idProyecto int,	
	@idEtapa int,
	@idRequerimiento int,
	@idRequisicion int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 28/Marzo/16
-- Descripcion: Se carga el detalle de la requisicion
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idRequerimiento @idRequisicion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	select dr.idDetalleRequisicion, dr.idMaterial, ma.nombreMaterial, um1.nombreCortoUnidadMedida,
			ma.calidadMaterial, ma.anchoMaterial, ma.largoMaterial, dr.cantidadSolicitada, 
			CASE WHEN dr.cantidadSolicitada - isnull( dr.cantidadRecibida,0)  IS NULL THEN 0 ELSE dr.cantidadSolicitada - isnull( dr.cantidadRecibida,0) END AS Saldo,
			CASE WHEN dr.cantidadRecibida IS NULL THEN 0 ELSE dr.cantidadRecibida END AS cantidadRecibida, ma.largoMaterial * 0.3048 LongArea, ma.pesoMaterial,
			(dr.cantidadSolicitada * (ma.largoMaterial * 0.3048) * ma.pesoMaterial) Total
	from cmiRequisiciones re
		inner join cmiDetallesRequisicion dr on re.idRequisicion = dr.idRequisicion
		inner join cmiRequerimientos req on re.idRequerimiento = req.idRequerimiento
		inner join cmiEtapas et on req.idEtapa = et.idEtapa
		inner join cmiProyectos pr on et.idProyecto = pr.idProyecto
		inner join cmiMateriales ma on dr.idMaterial = ma.idMaterial
		inner join cmiUnidadesMedida UM1 on dr.idUnidadMedida = UM1.idUnidadMedida
	where pr.idProyecto = @idProyecto
		and et.idEtapa = @idEtapa
		and req.idRequerimiento = @idRequerimiento
		and re.idRequisicion = @idRequisicion
		and re.autorizadoRequisicion = 1
	  
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRemision]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarRemision]
	@idRemision int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 25/Abril/16
-- Descripcion: Se cargan las Remisiones 
-- Parametros de salida:
-- Parametros de entrada:  @idRemision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idRemision]
		  ,T0.[estatusRemision]
		  ,T0.[usuarioCreacion]
		  ,convert(varchar(10), T0.fechaRemision, 103) fechaRemision
		  ,convert(varchar(10), T0.fechaEnvio, 103) fechaEnvio
		  ,T0.[transporte]
		  ,T0.[placas]
		  ,T0.[conductor]
		  ,T0.[idCliente]
		  ,T0.[idProyecto]
		  ,T0.[idEtapa]
		  ,T1.[nombreCliente]
		  ,T1.[direccionEntregaCliente]
		  ,T1.[contactoCliente]
	  FROM [dbo].[cmiRemisiones] T0
	  INNER JOIN cmiClientes T1 ON T1.idCliente = T0.idCliente
	  WHERE T0.idRemision = @idRemision;


END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRemisionDetalle]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarRemisionDetalle]
	@idRemision int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 25/Abril/16
-- Descripcion: Se cargan las Remisiones 
-- Parametros de salida:
-- Parametros de entrada:  @idRemision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT T0.[idRemision]
		,T0.[idOrdenEmbarque]
		,T1.[idOrdenProduccion]
		,convert(varchar(10), T1.fechaCreacion, 103) fechaCreacion
		,T1.[observacionOrdenEmbarque]
	FROM [cmiRemisionDetalle] T0
	INNER JOIN cmiOrdenesEmbarque T1 ON T1.idOrdenEmbarque = T0.idOrdenEmbarque
	WHERE T0.[idRemision] = @idRemision

END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRemisiones]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarRemisiones]
	@idProyecto int,	
	@idEtapa int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 25/Abril/16
-- Descripcion: Se cargan las Remisiones 
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto,@idEtapa,@idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idRemision]
		  ,T0.[estatusRemision]
		  ,T0.[usuarioCreacion]
		  ,convert(varchar(10), T0.fechaRemision, 103) fechaRemision
		  ,convert(varchar(10), T0.fechaEnvio, 103) fechaEnvio
		  ,T0.[transporte]
		  ,T0.[placas]
		  ,T0.[conductor]
		  ,T0.[idCliente]
		  ,T1.[nombreCliente]
	  FROM [dbo].[cmiRemisiones] T0
	  INNER JOIN cmiClientes T1 ON T1.idCliente = T0.idCliente
	  WHERE T0.[idEtapa] = ISNULL(@idEtapa,T0.[idEtapa])
		AND T0.[idProyecto] = ISNULL(@idProyecto,T0.[idProyecto])



END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRemisionesDetalle]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarRemisionesDetalle]
	@idRemision int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 26/Abril/16
-- Descripcion: Se carga el datalle de la Remision
-- Parametros de salida:
-- Parametros de entrada: @idRemision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT T0.idRemision, T0.idOrdenEmbarque,T2.idMarca,COUNT(T2.idSerie),
		T7.codigoMarca,T7.piezasMarca, T7.pesoMarca, T3.nombreProyecto, 
		T4.claveEtapa, T5.codigoPlanoMontaje, '' as Mensaje,
		(   SELECT count(idRemision) FROM cmiRegistrarRemision
			WHERE idRemision =@idRemision
			AND  idOrdenEmbarque = T0.idOrdenEmbarque
			AND idMarca = T2.idMarca ) piezasLeidas
	FROM cmiRemisionDetalle T0
	INNER JOIN cmiOrdenesEmbarque T1 ON T1.idOrdenEmbarque = T0.idOrdenEmbarque 
	INNER JOIN cmiDetalleOrdenEmbarque T2 ON T2.idOrdenEmbarque = T0.idOrdenEmbarque 
	INNER JOIN cmiProyectos T3 ON T3.idProyecto = T1.idProyecto 
	INNER JOIN cmiEtapas T4 ON T4.idEtapa= T1.idEtapa
	INNER JOIN cmiPlanosMontaje T5 ON T5.idEtapa = T1.idEtapa
	INNER JOIN cmiPlanosDespiece T6 ON T5.idPlanoMontaje = T6.idPlanoMontaje
	INNER JOIN cmiMarcas T7 ON T7.idPlanoDespiece = T6.idPlanoDespiece
							AND T7.idMarca = T2.idMarca
	INNER JOIN cmiSeries T8 ON T8.idMarca = T2.idMarca
							AND T8.idSerie = T2.idSerie
	WHERE T0.idRemision = @idRemision
	GROUP BY T0.idRemision, T0.idOrdenEmbarque,T2.idMarca,
		T7.codigoMarca,T7.piezasMarca, T7.pesoMarca,  
		T3.nombreProyecto,T4.claveEtapa, 
		T5.codigoPlanoMontaje
	ORDER BY T0.idOrdenEmbarque;

END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteDetaOE]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarReporteDetaOE]
	@idOrdenEmbarque int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 30/Abril/16
-- Descripcion: Se carga el datalle del Reporte para la Orden de Embarque
-- Parametros de salida:
-- Parametros de entrada: @idOrdenEmbarque
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.idMarca, count (T0.idSerie) as piezasMarca,T6.nombreMarca,T6.pesoMarca,t4.nombrePlanoMontaje
	FROM cmiDetalleOrdenEmbarque T0	
	INNER JOIN cmiOrdenesEmbarque T1 ON T1.idOrdenEmbarque = T0.idOrdenEmbarque 
	INNER JOIN cmiProyectos T2 ON T2.idProyecto = T1.idProyecto 
	INNER JOIN cmiEtapas T3 ON T3.idEtapa= T1.idEtapa
	INNER JOIN cmiPlanosMontaje T4 ON T4.idEtapa = T1.idEtapa
	INNER JOIN cmiPlanosDespiece T5 ON T5.idPlanoMontaje= T4.idPlanoMontaje
	INNER JOIN cmiMarcas T6 ON T6.idMarca = T0.idMarca and
								t5.idPlanoDespiece = T6.idPlanoDespiece
	WHERE T0.idOrdenEmbarque = @idOrdenEmbarque
	GROUP BY T0.idMarca,T6.nombreMarca,T6.pesoMarca,t4.nombrePlanoMontaje

END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionAvanceProyecto]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarReporteProduccionAvanceProyecto]
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
		
		SELECT @FechaIni = MIN(AC.fechaActividad), @FechaFin = MAX(AC.fechaActividad)
		FROM cmiActividadesProduccion AC
		INNER JOIN cmiMarcas M ON M.idMarca = AC.idMarca
		INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
		INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
		WHERE AC.claseActividad = 'M' AND PM.idPlanoMontaje = @curIdPlanoMontaje

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



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionCalidad]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CargarReporteProduccionCalidad]
	@IdProyecto INT,
	@FechaInicio VARCHAR(10),
	@FechaFin VARCHAR(10)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 04/Abril/16
-- Descripcion: Reporte Calidad
-- Parametros de salida:
-- Parametros de entrada:
******************************************

EXEC usp_CargarReporteProduccionCalidad 1, '01/04/2016', '30/04/2016'

*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @dFechaInicio DATETIME = CONVERT(DATETIME, @FechaInicio, 103);
	DECLARE @dFechaFin DATETIME = CONVERT(DATETIME, @FechaFin, 103) + ' ' + CONVERT(VARCHAR(8),'23:59:59',14)

	SELECT AP.idActividad AS idRegistroCalidad
		   ,CONVERT(VARCHAR(10),AP.fechaActividad,103) AS fechaRegistroCalidad
		   ,P.nombreProyecto
		   ,E.nombreEtapa
		   ,M.nombreMarca
		   ,S.idSerie
		   ,M.pesoMarca
		   ,PR.nombreProceso
		   ,CONCAT(RTRIM(U.nombreUsuario),' ',RTRIM(U.apePaternoUsuario),' ',RTRIM(U.apeMaternoUsuario)) AS nombreUsuario
		   ,CASE AP.longitudCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS longitudRegistroCalidad
		   ,CASE AP.barrenacionCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS barrenacionRegistroCalidad
		   ,CASE AP.placaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS placaRegistroCalidad
		   ,CASE AP.soldaduraCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS soldaduraRegistroCalidad
		   ,CASE AP.pinturaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS pinturaRegistroCalidad
		   ,ES.nombreEstatus
		   ,ISNULL(AP.observacionesCalidad,'') AS observacionesRegistroCalidad
	FROM cmiActividadesProduccion AP
	INNER JOIN cmiSeries S ON AP.idMarca = S.idMarca AND S.idSerie = AP.idSerie
	INNER JOIN cmiMarcas M ON M.idMarca = S.idMarca
	INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
	INNER JOIN cmiUsuarios U ON U.idUsuario = AP.idUsuarioFabrico
	INNER JOIN cmiEstatus ES ON ES.idEstatus = AP.idEstatus_Calidad
	WHERE P.idProyecto = @IdProyecto
	AND AP.fechaActividad >= @dFechaInicio
	AND AP.fechaActividad <= @dFechaFin
	AND AP.claseActividad = 'M' AND AP.tipoActividad = 'C'
	
	UNION

	SELECT AP.idActividad AS idRegistroCalidad
		   ,CONVERT(VARCHAR(10),AP.fechaActividad,103) AS fechaRegistroCalidad
		   ,P.nombreProyecto
		   ,E.nombreEtapa
		   ,M.nombreMarca
		   ,SM.codigoSubMarca
		   ,SM.pesoSubMarca
		   ,PR.nombreProceso
		   ,CONCAT(RTRIM(U.nombreUsuario),' ',RTRIM(U.apePaternoUsuario),' ',RTRIM(U.apeMaternoUsuario)) AS nombreUsuario
		   ,CASE AP.longitudCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS longitudRegistroCalidad
		   ,CASE AP.barrenacionCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS barrenacionRegistroCalidad
		   ,CASE AP.placaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS placaRegistroCalidad
		   ,CASE AP.soldaduraCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS soldaduraRegistroCalidad
		   ,CASE AP.pinturaCalidad
				WHEN 1 THEN 'SI' ELSE 'NO' END AS pinturaRegistroCalidad
		   ,ES.nombreEstatus
		   ,AP.observacionesCalidad
	FROM cmiActividadesProduccion AP
	INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = AP.idSubmarca
	INNER JOIN cmiMarcas M ON M.idMarca = SM.idMarca
	INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
	INNER JOIN cmiUsuarios U ON U.idUsuario = AP.idUsuarioFabrico
	INNER JOIN cmiEstatus ES ON ES.idEstatus = AP.idEstatus_Calidad
	WHERE P.idProyecto = @IdProyecto
	AND AP.fechaActividad >= @dFechaInicio
	AND AP.fechaActividad <= @dFechaFin
	AND AP.claseActividad = 'S' AND AP.tipoActividad = 'C'
END







GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionDiasProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarReporteProduccionDiasProceso]
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







GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionEstatusProyecto]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CargarReporteProduccionEstatusProyecto]
	@IdProyecto int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 14/Abril/16
-- Descripcion: Reporte Produccion ESTATUS PROYECTO
-- Parametros de salida:
-- Parametros de entrada:
******************************************

EXEC usp_CargarReporteProduccionEstatusProyecto 1

*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @nombreCategoria NVARCHAR(50);
	DECLARE @idProcesoEnsamble INT = -1;

	SELECT @nombreCategoria = C.nombreCategoria
	FROM cmiProyectos P
	INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
	WHERE P.idProyecto = @IdProyecto;

	SELECT @idProcesoEnsamble = idProceso
	FROM cmiProcesos
	WHERE nombreProceso = 'ENSAMBLE';
	
	WITH cte(idProceso, proceso, categoria) AS
	(SELECT PR.idProceso, PR.nombreProceso, C.nombreCategoria
	 FROM cmiRutasFabricacion RF
	 INNER JOIN cmiProyectos P ON P.idCategoria = RF.idCategoria
	 INNER JOIN cmiCategorias C ON C.idCategoria = P.idCategoria
	 INNER JOIN cmiProcesos PR ON PR.idProceso = RF.idProceso
	 WHERE P.idProyecto = @IdProyecto
	 UNION SELECT 1000 AS idProceso, 'EMBARCADO' AS nombreProceso, @nombreCategoria
	 UNION SELECT 1001 AS idProceso, 'RECIBIDO' AS nombreProceso, @nombreCategoria
	)
	SELECT  concat(cte.idProceso,'-',ISNULL(tbl.idMarca,0),'-',ISNULL(tbl.idSerie,0)) AS id, 
			cte.proceso,
			CASE ISNULL(tbl.nombreProyecto,'') WHEN '' THEN '' ELSE cte.categoria END AS categoria,
			ISNULL(tbl.nombreProyecto,'') AS proyecto,
			ISNULL(tbl.nombreEtapa,'') AS etapa,
			ISNULL(tbl.nombrePlanoMontaje,'') AS planoMontaje,
			ISNULL(tbl.nombrePlanoDespiece,'') AS planoDespiece,
			ISNULL(tbl.elemento,'') AS marca,
			ISNULL(tbl.idSerie,'') AS serie,
			ISNULL(DATEDIFF(DAY,tbl.fechaUltModificacion,GETDATE()),0) AS diasProceso,
			CASE ISNULL(tbl.idProcesoActual,'') WHEN '' THEN '' ELSE 1 END AS piezas,
			CASE ISNULL(tbl.idProcesoActual,'') WHEN '' THEN '' WHEN 0 THEN 1 ELSE tbl.pesoMarca END AS peso
	FROM cte
	LEFT JOIN
	(SELECT CASE 
			WHEN idProcesoActual IS NULL		-- No tiene avance, se va a ensamble
			THEN @idProcesoEnsamble
			WHEN idProcesoActual IS NOT NULL	-- Tiene avance y
				AND DOE.idOrdenEmbarque IS NULL -- no tiene Orden de Embarque
			THEN idProcesoActual
			WHEN idProcesoActual IS NOT NULL -- Tiene Avance y
				AND DOE.idOrdenEmbarque IS NOT NULL -- tiene Orden Embarque y
				AND RR.idOrdenEmbarque IS NULL -- no tiene Remision
			THEN 1000
			WHEN idProcesoActual IS NOT NULL -- Tiene Avance y
				AND DOE.idOrdenEmbarque IS NOT NULL -- tiene Orden Embarque y
				AND RR.idOrdenEmbarque IS NOT NULL -- tiene Remision THEN 'Other sale items'
			THEN 1001
			ELSE -1
     END AS idProcesoActual, 
			M.idMarca, 
			M.nombreMarca AS elemento, 
			S.idSerie,
			PD.nombrePlanoDespiece, 
			PM.nombrePlanoMontaje, 
			E.nombreEtapa, 
			P.nombreProyecto, 
			M.fechaUltModificacion,
			M.pesoMarca
     FROM cmiSeries S
	 INNER JOIN cmiMarcas M ON M.idMarca = S.idMarca
	 INNER JOIN cmiPlanosDespiece PD ON PD.idPlanoDespiece = M.idPlanoDespiece
	 INNER JOIN cmiPlanosMontaje PM ON PM.idPlanoMontaje = PD.idPlanoMontaje
	 INNER JOIN cmiEtapas E ON E.idEtapa = PM.idEtapa
	 INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
	 LEFT JOIN cmiDetalleOrdenEmbarque DOE ON DOE.idMarca = S.idMarca AND DOE.idSerie = S.idSerie
	 LEFT JOIN cmiRegistrarRemision RR ON RR.idMarca = S.idMarca AND RR.idSerie = S.idSerie
	 WHERE P.idProyecto = @IdProyecto
	) tbl ON cte.idProceso = tbl.idProcesoActual
	ORDER BY idProceso, elemento, serie
		
END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionPorPersona]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarReporteProduccionPorPersona]
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

EXEC usp_CargarReporteProduccionPorPersona 1, '01/02/2016', '30/07/2016'

*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @dFechaInicio DATETIME = CONVERT(DATETIME, @FechaInicio, 103);
	DECLARE @dFechaFin DATETIME = CONVERT(DATETIME, @FechaFin, 103) + ' ' + CONVERT(VARCHAR(8),'23:59:59',14);

	WITH cte (id, fecha, idUsuario, nombreUsuario, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, piezas, peso) 
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
				AP.piezasActividad,
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
				AP.piezasActividad,
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
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, CASE WHEN piezas = 0 THEN 1 ELSE piezas END AS piezas, peso
	FROM cte
	WHERE idProyecto = @IdProyecto
		AND fecha >= @dFechaInicio
		AND fecha <= @dFechaFin
	ORDER BY idUsuario, fecha
		
END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReporteProduccionSemanal]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarReporteProduccionSemanal]
	@IdProyecto int,
	@FechaInicio VARCHAR(10),
	@FechaFin VARCHAR(10)
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 04/Abril/16
-- Descripcion: Reporte Produccion Por Persona
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @dFechaInicio DATETIME = CONVERT(DATETIME, @FechaInicio, 103);
	DECLARE @dFechaFin DATETIME = CONVERT(DATETIME, @FechaFin, 103) + ' ' + CONVERT(VARCHAR(8),'23:59:59',14);

	WITH cte (id, fecha, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, piezas, peso) 
	AS (
		-- MARCAS
		SELECT	AP.idActividad AS id,
				AP.fechaActividad AS fecha,
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'MARCA' AS clase,
				M.nombreMarca AS nombreElemento,
				AP.idSerie,
				PR.nombreProceso,
				AP.piezasActividad,
				M.pesoMarca AS peso
		FROM cmiActividadesProduccion AP
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
				P.idProyecto,
				P.nombreProyecto,
				E.nombreEtapa,
				'SUBMARCA' AS clase,
				SM.codigoSubMarca AS nombreElemento,
				'' AS idSerie,
				PR.nombreProceso,
				AP.piezasActividad,
				SM.pesoSubMarca AS peso
		FROM cmiActividadesProduccion AP
		INNER JOIN cmiSubMarcas SM ON SM.idSubMarca = AP.idSubmarca
		INNER JOIN cmiEtapas E ON E.idEtapa = SM.idOrdenProduccion
		INNER JOIN cmiProyectos P ON P.idProyecto = E.idProyecto
		INNER JOIN cmiProcesos PR ON PR.idProceso = AP.idProceso
		WHERE AP.claseActividad = 'S' 
	)
	SELECT id, convert(varchar(10), fecha, 103) AS fecha, idProyecto, nombreProyecto, 
			nombreEtapa, clase, nombreElemento, idSerie, nombreProceso, CASE WHEN piezas = 0 THEN 1 ELSE piezas END AS piezas, peso
	FROM cte
	WHERE idProyecto = @IdProyecto
		AND fecha >= @dFechaInicio
		AND fecha <= @dFechaFin
	ORDER BY fecha
		
END











GO
/****** Object:  StoredProcedure [dbo].[usp_CargarReqGenMat]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarReqGenMat]
	@idProyecto int,
	@idEtapa int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 28/Marzo/16
-- Descripcion: Se cargan el Requerimiento General de Materiales
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto, @idEtapa
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T1.nombreEtapa,T1.claveEtapa, T2.nombreProyecto, T2.codigoProyecto,T2.revisionProyecto,
		   T0.folioRequerimiento,T0.idRequerimiento,T3.nombreDepartamento,T4.nombreUsuario,
		   T4.apeMaternoUsuario, T4.apePaternoUsuario,T0.usuarioSolicita,
		   T5.numeroRenglon,T5.perfilDetalleReq,T5.piezasDetalleReq,T5.cortesDetalleReq,
		   T5.logitudDetalleReq,T5.anchoDetalleReq,T5.gradoDetalleReq, T5.kgmDetalleReq,
		   T5.totalLADetalleReq,T5.pesoDetalleReq,T5.areaDetalleReq,
		   convert(varchar(10), T0.fechaSolicitud, 103)  fechaSolicitud
	FROM cmiRequerimientos T0
	INNER JOIN cmiEtapas T1 ON T1.idEtapa = @idEtapa
	INNER JOIN cmiProyectos T2 ON T2.idProyecto= T1.idProyecto
	INNER JOIN cmiDepartamentos T3 ON T3.idDepartamento = T0.idDepartamento
	INNER JOIN cmiUsuarios T4 ON T4.idUsuario = T0.usuarioSolicita
	INNER JOIN cmiDetalleRequerimiento T5 ON T5.idRequerimiento = T0.idRequerimiento
	WHERE T0.idEtapa = @idEtapa
  

END
----------------------





GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRequerimientosGral]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarRequerimientosGral]
	@idEtapa int,	
	@idProyecto int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 16/Febrero/16
-- Descripcion: Se cargan los requerimientos
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa @idProyecto @idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT re.idRequerimiento
		,convert(varchar(10), re.fechaSolicitud, 101) as fechaSolicitud
		,pr.idProyecto 
		,pr.nombreProyecto
		,pr.codigoProyecto
		,pr.revisionProyecto
		,ori.nombreOrigenRequisicion
		,de.nombreDepartamento
		,usu.nombreUsuario AS usurioSolicita
		,et.idEtapa
		,et.nombreEtapa
		,convert(varchar(10), et.fechaInicioEtapa, 101) as fechaInicioEtapa
		,convert(varchar(10), et.fechaFinEtapa, 101) as fechaFinEtapa
		,es.nombreEstatus
		,re.folioRequerimiento
		FROM cmiRequerimientos AS re
		INNER JOIN cmiEtapas AS et ON re.idEtapa = et.idEtapa
		INNER JOIN cmiProyectos AS pr ON et.idProyecto = pr.idProyecto
		INNER JOIN cmiOrigenesRequisicion AS ori ON re.idOrigenRequisicion = ori.idOrigenRequisicion
		INNER JOIN cmiDepartamentos AS de ON re.idDepartamento = de.idDepartamento
		INNER JOIN cmiUsuarios AS usu ON re.usuarioSolicita = usu.idUsuario
		INNER JOIN cmiEstatus AS es ON re.idEstatus = es.idEstatus 
		WHERE pr.idProyecto = ISNULL(@idProyecto,pr.idProyecto)
		AND et.idEtapa = ISNULL(@idEtapa,et.idEtapa)
		AND re.idEstatus = ISNULL(@idStatus,re.idEstatus)  

END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRequerimientosGralId]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarRequerimientosGralId]
	@idEtapa int,	
	@idProyecto int,
	@idRequerimiento int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 16/Febrero/16
-- Descripcion: Se cargan los requerimientos
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa @idRequerimiento @idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	select dre.numeroRenglon
			,dre.perfilDetalleReq
			,dre.piezasDetalleReq
			,dre.cortesDetalleReq
			,dre.logitudDetalleReq
			,dre.anchoDetalleReq
			,dre.gradoDetalleReq
			,dre.kgmDetalleReq
			,dre.totalLADetalleReq
			,dre.pesoDetalleReq
		FROM cmiDetalleRequerimiento AS dre
		INNER JOIN cmiRequerimientos re on dre.idRequerimiento = re.idRequerimiento
		INNER JOIN cmiEtapas AS et ON re.idEtapa = et.idEtapa
		INNER JOIN cmiProyectos AS pr ON et.idProyecto = pr.idProyecto
		WHERE re.idRequerimiento = ISNULL(@idRequerimiento,re.idRequerimiento)
		AND et.idEtapa = ISNULL(@idEtapa,et.idEtapa)
		AND et.idProyecto = ISNULL(@idProyecto,et.idProyecto)
		AND re.idEstatus = ISNULL(	@idStatus,re.idEstatus)  

END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRequisiciones]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarRequisiciones]
	@idEtapa int,	
	@idProyecto int,
	@idRequerimiento int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 16/Marzo/16
-- Descripcion: Se cargan los requisiciones
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa @idProyecto @idRequisicion @idStatus
******************************************
*/
BEGIN

 	SET NOCOUNT ON;


		SELECT distinct rq.idRequisicion
			,ori.nombreOrigenRequisicion
			,dr.causaRequisicion
			,(CASE WHEN rq.autorizadoRequisicion = 1 THEN 'Autorizada' WHEN  rq.autorizadoRequisicion = 0 THEN 'Rechazada' ELSE '' END) AS Estatus
			,rq.idAlmacen, rq.serieRequisicion, rq.facturaRequisicion, rq.proveedorRequisicion,convert(varchar(10), rq.fechaFacturaRequisicion, 101) as fechaFacturaRequisicion
		FROM cmiEtapas AS et
			INNER JOIN cmiProyectos AS pr ON et.idProyecto = pr.idProyecto
			INNER JOIN cmiRequerimientos AS re ON et.idEtapa = re.idEtapa
			INNER JOIN cmiRequisiciones AS rq ON re.idRequerimiento = rq.idRequerimiento
			INNER JOIN cmiDetallesRequisicion dr ON rq.idRequisicion = dr.idRequisicion 
			INNER JOIN cmiOrigenesRequisicion AS ori ON dr.idOrigenRequisicion = ori.idOrigenRequisicion 
		WHERE et.idProyecto = @idProyecto
			AND et.idEtapa = @idEtapa
			AND re.idRequerimiento = @idRequerimiento
			AND re.idEstatus = @idStatus

END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRptRequerimiento]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarRptRequerimiento]
	@idProyecto int,	
	@idEtapa int,
	@idRequerimiento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Marzo/16
-- Descripcion: Se carga la informacion para generar el header del reporte requerimiento
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

		SELECT pr.idProyecto
			,pr.nombreProyecto
			,et.idEtapa
			,et.nombreEtapa
			,re.folioRequerimiento
			,de.nombreDepartamento
			,us.nombreUsuario
		FROM cmiEtapas AS et
		INNER JOIN cmiProyectos AS pr ON et.idProyecto = pr.idProyecto
		INNER JOIN cmiRequerimientos AS re ON et.idEtapa = re.idEtapa
		INNER JOIN cmiDepartamentos AS de ON re.idDepartamento = de.idDepartamento
		INNER JOIN cmiUsuarios AS us ON re.usuarioSolicita = us.idUsuario
		WHERE et.idProyecto = @idProyecto
			AND et.idEtapa = @idEtapa
			AND re.idRequerimiento = @idRequerimiento
	  
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRptRequisicion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarRptRequisicion]
	@idProyecto int,	
	@idEtapa int,
	@idRequerimiento int
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Marzo/16
-- Descripcion: Se carga la informacion para generar el header del reporte REQUISICIONES
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto @idEtapa @idRequerimiento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

		SELECT distinct pr.idProyecto
			,pr.nombreProyecto
			,et.idEtapa
			,et.nombreEtapa
			,rq.folioRequisicion
			,de.nombreDepartamento
			,us.nombreUsuario
		FROM cmiEtapas AS et
		INNER JOIN cmiProyectos AS pr ON et.idProyecto = pr.idProyecto
		INNER JOIN cmiRequerimientos AS re ON et.idEtapa = re.idEtapa
		INNER JOIN cmiDepartamentos AS de ON re.idDepartamento = de.idDepartamento
		INNER JOIN cmiUsuarios AS us ON re.usuarioSolicita = us.idUsuario
		INNER JOIN cmiRequisiciones AS rq ON re.idRequerimiento = rq.idRequerimiento
		WHERE et.idProyecto = @idProyecto
			AND et.idEtapa = @idEtapa
			AND re.idRequerimiento = @idRequerimiento
	  
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRutasFabricacion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[usp_CargarRutasFabricacion]
	@IdRutaFabricacion int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Se cargan las Rutas de Fabricacion
-- Parametros de salida:
-- Parametros de entrada:  @IdRutaFabricacion @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiRutasFabricacion].[idRutaFabricacion]
			,[dbo].[cmiRutasFabricacion].[fechaCreacion]
			,[dbo].[cmiRutasFabricacion].[fechaUltModificacion]
			,[dbo].[cmiRutasFabricacion].[usuarioCreacion]
			,[dbo].[cmiRutasFabricacion].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiRutasFabricacion].[idCategoria]
			,[dbo].[cmiCategorias].[nombreCategoria]
			,[dbo].[cmiRutasFabricacion].[secuenciaRutaFabricacion]
			,[dbo].[cmiRutasFabricacion].[idProceso]
			,[dbo].[cmiProcesos].[nombreProceso]
	FROM [dbo].[cmiRutasFabricacion]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiRutasFabricacion].[idEstatus]
	INNER JOIN [dbo].[cmiCategorias] ON [dbo].[cmiCategorias].[idCategoria] = [dbo].[cmiRutasFabricacion].[idCategoria]
	INNER JOIN [dbo].[cmiProcesos] ON [dbo].[cmiProcesos].[idProceso] = [dbo].[cmiRutasFabricacion].[idProceso]
	WHERE [dbo].[cmiRutasFabricacion].[idRutaFabricacion] = ISNULL(@IdRutaFabricacion, [dbo].[cmiRutasFabricacion].[idRutaFabricacion])
		AND [dbo].[cmiRutasFabricacion].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiRutasFabricacion].[idEstatus])
		
END






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarSiguienteProcesoRutaFabricacion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CargarSiguienteProcesoRutaFabricacion]
	@IdProyecto int,
	@IdProceso int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 25/Marzo/16
-- Descripcion: Se cargan los Procesos
-- Parametros de salida:
-- Parametros de entrada:  @IdProyecto, @idProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT P.idProceso
		  ,P.nombreProceso
		  ,P.idTipoProceso
		  ,TP.nombreTipoProceso
	FROM cmiRutasFabricacion RF
	INNER JOIN cmiProcesos P ON P.idProceso = RF.idProceso
	INNER JOIN cmiTiposProceso TP ON TP.idTipoProceso = P.idTipoProceso
	WHERE RF.secuenciaRutaFabricacion = 1 + (SELECT TOP 1 RF2.secuenciaRutaFabricacion
											 FROM cmiRutasFabricacion RF2
											 INNER JOIN cmiProyectos PR ON RF2.idCategoria = PR.idCategoria
											 WHERE RF2.idProceso = @IdProceso
												AND PR.idProyecto = @IdProyecto)
END






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarSubMarcas]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarSubMarcas]
	@idMarca int,	
	@idSubMarca int,
	@idStatus int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 09/Marzo/16
-- Descripcion: Se cargan las SubMarcas de una Marca
-- Parametros de salida:
-- Parametros de entrada:  @idMarca,@idSubMarca, @idStatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idSubMarca]
		  ,convert(varchar(10), T0.[fechaCreacion], 103)  fechaCreacion
		  ,T0.[idEstatus]
		  ,T0.[idMarca]
		  ,T0.[perfilSubMarca]
		  ,T0.[piezasSubMarca]
		  ,T0.[corteSubMarca]
		  ,T0.[longitudSubMarca]
		  ,T0.[anchoSubMarca]
		  ,T0.[gradoSubMarca]
		  ,T0.[kgmSubMarca]
		  ,T0.[totalLASubMarca]
		  ,T0.[pesoSubMarca]
		  ,T0.[codigoSubMarca]
		  ,T0.[claseSubMarca]
		  ,T0.[totalSubMarca]
		  ,T0.[alturaSubMarca]
		  ,T1.[nombreEstatus]
	  FROM [cmiSubMarcas] T0
	  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]  
	  WHERE T0.[idMarca] = ISNULL(@idMarca,T0.[idMarca])
	  AND T0.[idSubMarca] = ISNULL(@idSubMarca,T0.[idSubMarca])  
	  AND T0.[idEstatus] = ISNULL(@idStatus,T0.[idEstatus])
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposCalidad]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_CargarTiposCalidad]
	@IdTipoCalidad int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los Tipos de Calidad
-- Parametros de salida:
-- Parametros de entrada:  @IdTipoCalidad @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiTiposCalidad].[idTipoCalidad]
			,[dbo].[cmiTiposCalidad].[fechaCreacion]
			,[dbo].[cmiTiposCalidad].[fechaUltModificacion]
			,[dbo].[cmiTiposCalidad].[usuarioCreacion]
			,[dbo].[cmiTiposCalidad].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiTiposCalidad].[nombreTipoCalidad]
	FROM [dbo].[cmiTiposCalidad]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiTiposCalidad].[idEstatus] = [dbo].[cmiEstatus].[idEstatus]
	WHERE [dbo].[cmiTiposCalidad].[idTipoCalidad] = ISNULL(@IdTipoCalidad, [dbo].[cmiTiposCalidad].[idTipoCalidad])
		AND [dbo].[cmiTiposCalidad].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiTiposCalidad].[idEstatus])
		
END
----------------------






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposConstruccion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarTiposConstruccion]
	@idTipoConstruccion int,
	@idEstaus int	
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los tipos de construccion 
-- Parametros de salida:
-- Parametros de entrada:  @idTipoConstruccion @idEstaus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idTipoConstruccion
				,tc.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,tc.idEstatus
				,nombreEstatus
				,nombreTipoConstruccion	 
	  FROM  cmiTiposConstruccion as tc
	  inner join cmiEstatus as es on tc.idEstatus = es.idEstatus
	  where idTipoConstruccion = ISNULL(@idTipoConstruccion,idTipoConstruccion)
	  and tc.idEstatus = ISNULL(@idEstaus,tc.idEstatus)
	  
		
END
----------------------






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_CargarTiposMaterial]
	@IdTipoMaterial int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Se cargan los Tipos de Material
-- Parametros de salida:
-- Parametros de entrada:  @IdTipoMaterial, @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiTiposMaterial].[idTipoMaterial]
			,[dbo].[cmiTiposMaterial].[fechaCreacion]
			,[dbo].[cmiTiposMaterial].[fechaUltModificacion]
			,[dbo].[cmiTiposMaterial].[usuarioCreacion]
			,[dbo].[cmiTiposMaterial].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiTiposMaterial].[nombreTipoMaterial]
	FROM [dbo].[cmiTiposMaterial]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiTiposMaterial].[idEstatus] = [dbo].[cmiEstatus].[idEstatus]
	WHERE [dbo].[cmiTiposMaterial].[idTipoMaterial] = ISNULL(@IdTipoMaterial, [dbo].[cmiTiposMaterial].[idTipoMaterial])
		AND [dbo].[cmiTiposMaterial].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiTiposMaterial].[idEstatus])
		
END
----------------------





GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMovtoMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposMovtoMaterial]
	@idTipoMovtoMaterial int,
	@idEstatus int		
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los tipos de mterial 
-- Parametros de salida:
-- Parametros de entrada:  @idTipoMovtoMaterial @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idTipoMovtoMaterial
				,tm.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,tm.idEstatus
				,nombreEstatus
				,nombreTipoMovtoMaterial
				,tipoMovtoMaterial	 
	  FROM  cmiTiposMovtoMaterial as tm
	  INNER JOIN cmiEstatus as es on tm.idEstatus = es.idEstatus
	  where idTipoMovtoMaterial = ISNULL(@idTipoMovtoMaterial,idTipoMovtoMaterial)
	  and tm.idEstatus = ISNULL(@idEstatus,tm.idEstatus)
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarTiposProceso]
	@idTipoProceso int,
	@idEstatus int		
AS
/*
******************************************
-- Nombre:	David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Se cargan los tipos de proceso 
-- Parametros de salida:
-- Parametros de entrada:  @idTipoProceso @idEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT idTipoProceso
				,tp.fechaCreacion
				,fechaUltModificacion
				,usuarioCreacion
				,tp.idEstatus
				,nombreEstatus
				,nombreTipoProceso	 
	  FROM  cmiTiposProceso as tp
	  inner join cmiEstatus as es on tp.idEstatus = es.idEstatus
	  where idTipoProceso = ISNULL(@idTipoProceso,idTipoProceso)
	  and tp.idEstatus = ISNULL(@idEstatus,tp.idEstatus)
		
END



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarTrasmital]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarTrasmital]
	@idEtapa int,
	@idUsuario int	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 04/Abril/16
-- Descripcion: Se carga la informacion para los reportes Trasmital
-- Parametros de salida:
-- Parametros de entrada:  @idEtapa @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT  T1.nombrePlanoMontaje, T1.codigoPlanoMontaje,
		    T2.codigoPlanoDespiece, T2.nombrePlanoDespiece
	FROM cmiEtapas T0
	INNER JOIN cmiPlanosMontaje T1 ON T1.idEtapa = T0.idEtapa AND T1.idEstatus= 1
	INNER JOIN cmiPlanosDespiece T2 ON T2.idPlanoMontaje = T1.idPlanoMontaje AND T2.idEstatus= 1
	WHERE T0.idEtapa = @idEtapa
	
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUnidadesMedida]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_CargarUnidadesMedida]
	@IdUnidadMedida int,
	@IdEstatus int
AS
/*
******************************************
-- Nombre:	Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Se cargan las unidades de medida
-- Parametros de salida:
-- Parametros de entrada:  @IdUnidadMedida, @IdEstatus
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	SELECT	 [dbo].[cmiUnidadesMedida].[idUnidadMedida]
			,[dbo].[cmiUnidadesMedida].[fechaCreacion]
			,[dbo].[cmiUnidadesMedida].[fechaUltModificacion]
			,[dbo].[cmiUnidadesMedida].[usuarioCreacion]
			,[dbo].[cmiUnidadesMedida].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiUnidadesMedida].[nombreCortoUnidadMedida]
			,[dbo].[cmiUnidadesMedida].[nombreUnidadMedida]
	FROM [dbo].[cmiUnidadesMedida]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiUnidadesMedida].[idEstatus] = [dbo].[cmiEstatus].[idEstatus]
	WHERE [dbo].[cmiUnidadesMedida].[idUnidadMedida] = ISNULL(@IdUnidadMedida, [dbo].[cmiUnidadesMedida].[idUnidadMedida]) 
		AND [dbo].[cmiUnidadesMedida].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiUnidadesMedida].[idEstatus])
		
END
----------------------






GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarioPermisos]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarUsuarioPermisos]	
	@idUsuario int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 05/Febrero/2016
-- Descripcion: Se cargan los permisos del usuario 
-- Parametros de salida:
-- Parametros de entrada:  @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idModulo], 
			T0.[lecturaPermiso], 
			T0.[escrituraPermiso], 
			T0.[borradoPermiso], 
			T0.[clonadoPermiso],
			T1.[urlModulo],
			T1.[nombreModulo],
			T3.[idMenuGrupo],
			T3.[nombreMenuGrupo],
			T3.[iconGrupo]
	FROM [cmiPermisos] T0
	INNER JOIN [cmiModulos] T1 on T1.idModulo = T0.idModulo
	INNER JOIN [cmiModuloMenuGrupo] T2 on T2.idModulo = T0.idModulo
	INNER JOIN [cmiMenuGrupo] T3 on T3.idMenuGrupo = T2.idMenuGrupo
	WHERE T0.[idUsuario] = @idUsuario
	AND T0.[idEstatus] = 1
	AND T0.[lecturaPermiso] = 1
	ORDER BY T0.[idModulo], T1.ordenModulo
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarios]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE  PROCEDURE [dbo].[usp_CargarUsuarios]
	@idUsuario int	
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Se cargan los usuario 
-- Parametros de salida:
-- Parametros de entrada:  @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT T0.[idUsuario]
      ,T0.[nombreUsuario]
      ,T0.[apePaternoUsuario]
      ,T0.[apeMaternoUsuario]
      ,T0.[puestoUsuario]
      ,T0.[areaUsuario]
      ,T0.[idDepartamento]
      ,T0.[emailUsuario]
      ,T0.[loginUsuario]      
      ,T0.[passwordUsuario]
      ,T0.[autorizaRequisiciones]
      ,T0.[idProcesoOrigen]
      ,T0.[idProcesoDestino]
      ,T0.[fechaCreacion]
	  ,T0.[idEstatus]
	  ,T1.[nombreEstatus]
  FROM [cmiUsuarios] T0
  INNER JOIN [dbo].[cmiEstatus] T1 ON T1.[idEstatus] = T0.[idEstatus]
  WHERE T0.[idUsuario] = ISNULL(@idUsuario,T0.[idUsuario])
	  
		
END
----------------------



GO
/****** Object:  StoredProcedure [dbo].[usp_GenerarRequerimientos]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_GenerarRequerimientos]
	@idProyecto int,
	@idEtapa int,
    @usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 02/Febrero/16
-- Descripcion: Genera el documento de Requisiciones
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	-- Declaracion de variables
	DECLARE  @idOrigenRequisicion int
			,@idRequerimiento int
			,@idDepartamento int = 0
			,@idEstatusRevision int = 0
			,@fecha datetime = getdate();
	
	BEGIN TRANSACTION;

	BEGIN TRY
		
		SELECT top 1 @idEstatusRevision = idEstatusRevision
		FROM cmiProyectos 
		WHERE idProyecto = @idProyecto;

		IF @idEstatusRevision = 1
		BEGIN
			SELECT top 1 @idDepartamento = idDepartamento 
			FROM cmiUsuarios
			WHERE idUsuario = @usuarioCreacion;

			SELECT top 1 @idOrigenRequisicion = idOrigenRequisicion
			FROM cmiOrigenesRequisicion
			WHERE nombreOrigenRequisicion = 'INICIAL';


			INSERT INTO [dbo].[cmiRequerimientos]
					   ([fechaCreacion]
					   ,[fechaUltModificacion]
					   ,[idEstatus]
					   ,[folioRequerimiento]
					   ,[fechaSolicitud]
					   ,[idOrigenRequisicion]
					   ,[idDepartamento]
					   ,[usuarioSolicita]
					   ,[idEtapa]
					   ,[usuarioCreacion])
				 VALUES
					   (@fecha
					   ,@fecha
					   ,1
					   ,'Inicial'
					   ,@fecha
					   ,@idOrigenRequisicion
					   ,@idDepartamento
					   ,@usuarioCreacion
					   ,@idEtapa
					   ,@usuarioCreacion)

			SET @idRequerimiento = SCOPE_IDENTITY();

			INSERT INTO [dbo].[cmiDetalleRequerimiento]
					   ([idRequerimiento],[numeroRenglon],[perfilDetalleReq],[piezasDetalleReq]
					   ,[cortesDetalleReq],[logitudDetalleReq],[anchoDetalleReq],[gradoDetalleReq]
					   ,[kgmDetalleReq],[totalLADetalleReq],[pesoDetalleReq],[areaDetalleReq]
					   ,[idEstatus],[usuarioCreacion],[fechaCreacion],[fechaUltModificacion])
			SELECT @idRequerimiento as idRequerimiento ,ROW_NUMBER() OVER(ORDER BY T4.perfilSubMarca,T4.gradoSubMarca,T4.kgmSubMarca DESC)  AS NUM,T4.perfilSubMarca,SUM(T4.piezasSubMarca) Piezas,
					SUM(T4.corteSubMarca) corte,SUM(T4.longitudSubMarca) longitud,SUM(T4.anchoSubMarca) ancho,T4.gradoSubMarca,
					T4.kgmSubMarca,SUM(T4.totalLASubMarca) totalLA, SUM(T4.pesoSubMarca) peso,0 Area,
				   1 idEstatus,@usuarioCreacion idUsuario ,@fecha creacion,@fecha ultModifi	    
			FROM cmiEtapas T0
			INNER JOIN  cmiPlanosMontaje T1 ON T1.idEtapa = T0.idEtapa
			INNER JOIN cmiPlanosDespiece T2 ON T2.idPlanoMontaje = T1.idPlanoMontaje
			INNER JOIN cmiMarcas T3 ON T3.idPlanoDespiece = T2.idPlanoDespiece
			INNER JOIN cmiSubMarcas T4 ON T4.idMarca = T3.idMarca
			WHERE T0.idEtapa = @idEtapa
			GROUP BY T4.perfilSubMarca,T4.gradoSubMarca,T4.kgmSubMarca;--,T4.claseSubMarca;
			
			UPDATE cmiProyectos SET idEstatusRevision = 0
			WHERE idProyecto = @idProyecto;
	   END;
	   	
	   COMMIT TRANSACTION;
	   	
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION;
	END CATCH;	
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarActividadProduccion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarAlmacen]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarAlmacen]	
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Almacen
-- Parametros de salida:
-- Parametros de entrada: @Nombre @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiAlmacenes]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreAlmacen])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END










GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarCalidadProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[usp_InsertarCalidadProceso]	
	@idProceso int,
	@secuencia int,
	@idTipoCalidad int,
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Insertar un nuevo CalidadProceso
-- Parametros de salida:
-- Parametros de entrada: @idProceso @secuencia @idTipoCalidad @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiCalidadProceso]
			   ([idProceso]
			   ,[idTipoCalidad]
			   ,[fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[secuenciaCalidadProceso]
			   ,[idEstatus]
			   ,[usuarioCreacion])
		 VALUES
			   (@idProceso
			   ,@idTipoCalidad
			   ,GETDATE()
			   ,GETDATE()
			   ,@secuencia
			   ,1
			   ,@UsuarioCreacion)
    
	SELECT SCOPE_IDENTITY()
END







GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarCategoria]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarCategoria]	
	@nombreTCategoria varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo categoria
-- Parametros de salida:
-- Parametros de entrada: @nombreTCategoria 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiCategorias
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreCategoria
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1 
           ,@nombreTCategoria)
           
           SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarCliente]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarCliente]	
	@nombreCliente varchar(100),
	@direccionEntregaCliente varchar(100),
	@coloniaCliente varchar(100),
	@cpCliente int,
	@ciudadCliente varchar(100),
	@estadoCliente varchar(100),
	@paisCliente varchar(100),
	@contactoCliente varchar(100),
    @usuarioCreacion int,
	@Estatus int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo CLIENTE
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiClientes
           (fechaCreacion
			,fechaUltModificacion
			,idEstatus
			,nombreCliente
			,direccionEntregaCliente
			,coloniaCliente
			,cpCliente
			,ciudadCliente
			,estadoCliente
			,paisCliente
			,contactoCliente
			,usuarioCreacion
           )
     VALUES
           (GETDATE()
			,GETDATE()
			,@Estatus 
			,@nombreCliente
			,@direccionEntregaCliente
			,@coloniaCliente
			,@cpCliente
			,@ciudadCliente
			,@estadoCliente
			,@paisCliente
			,@contactoCliente
			,@usuarioCreacion 
           )
           
           SELECT SCOPE_IDENTITY()
END





GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarDepartamento]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarDepartamento]	
	@idEstatus int,
	@Nombre varchar(255),	
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 06/Febrero/2016
-- Descripcion: Insertar un nuevo Departamento
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [cmiDepartamentos]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[nombreDepartamento]
           ,[usuarioCreacion])
     VALUES
           (getdate()
           ,getdate()
           ,@idEstatus
           ,@Nombre
           ,@usuarioCreacion)
          
           SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarDetalleOrdenEmbarque]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarDetalleOrdenEmbarque]	
	@idOrdenEmbarque int,
	@idMarca int,
	@idSerie char(2),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/Abril/16
-- Descripcion: Insertar detalle de la orden de embarque
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/

BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [cmiDetalleOrdenEmbarque]
			   ([idOrdenEmbarque]
			   ,[idMarca]
			   ,[idSerie]
			   ,[estatusEmbarque]
			   ,[estatusEntrega]
			   ,[fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[usurioCreacion])
		 VALUES
			   (@idOrdenEmbarque
			   ,@idMarca
			   ,@idSerie
			   ,0
			   ,0
			   ,GETDATE()
			   ,GETDATE()
			   ,@usuarioCreacion);

END

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarEtapa]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarEtapa]	
	@estatusEtapa int,
	@nombreEtapa varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@idProyecto int,
	@revisionProyecto char(3),
	@infoGeneral varchar(250),
	@claveEtapa varchar(10),	
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 18/Febrero/16
-- Descripcion: Insertar una nueva Etapa al proyecto
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [cmiEtapas]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[idProyecto]
           ,[nombreEtapa]
           ,[estatusEtapa]
           ,[fechaInicioEtapa]
           ,[fechaFinEtapa]
           ,[infGeneralEtapa]
           ,[usuarioCreacion]
           ,[revisionProyecto]
		   ,[claveEtapa])
     VALUES
           (GETDATE()           
           ,GETDATE()
           ,1
           ,@idProyecto
           ,@nombreEtapa
           ,@estatusEtapa
           ,convert(datetime, @fechaInicio, 103)
           ,convert(datetime, @fechaFin, 103)
           ,@infoGeneral
           ,@usuarioCreacion
           ,@revisionProyecto
		   ,@claveEtapa)
     
           SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarGrupo]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarGrupo]	
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Insertar un nuevo Grupo
-- Parametros de salida:
-- Parametros de entrada: @Nombre @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiGrupos]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreGrupo])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END




GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMarca]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarMarca]
	@idEstatus int,
	@nombreMarca varchar(50),	
	@codigoMarca varchar(20),	
	@piezasMarca int,
	@pesoMarca float,
	@idPlanoDespiece int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 01/Marzo/16
-- Descripcion: Insertar una nueva Marca
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;

	-- Declaracion de variables
	DECLARE  @idMarca int
			,@cont int = 1;
	
	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO [cmiMarcas]
				   ([fechaCreacion]
				   ,[fechaUltModificacion]
				   ,[idEstatus]
				   ,[idPlanoDespiece]
				   ,[codigoMarca]
				   ,[nombreMarca]
				   ,[piezasMarca]
				   ,[pesoMarca]
				   ,[usuarioCreacion])
			 VALUES
				   (getdate()
				   ,getdate()
				   ,@idEstatus
				   ,@idPlanoDespiece
				   ,@codigoMarca
				   ,@nombreMarca
				   ,@piezasMarca
				   ,@pesoMarca
				   ,@usuarioCreacion)

		SET @idMarca = SCOPE_IDENTITY();
		
		-- Serie
		WHILE @cont <= @piezasMarca
		BEGIN
		
			INSERT INTO cmiSeries ( idMarca
								   ,idSerie
								   ,idEstatus
								   ,idUsuario )
					VALUES		  ( @idMarca
								   ,[dbo].[ufn_getCodigoSerie] (@cont)
								   ,@idEstatus
								   ,@usuarioCreacion);
			SET @cont = @cont + 1;

		END;

		COMMIT TRANSACTION;
		SELECT @idMarca;
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION;
	END CATCH;	
END;


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarMaterial]	
	@nombreMaterial varchar(100),
	@anchoM numeric,
	@idUMAncho int,
	@largoM numeric,
	@idUMLargo int,
	@pesoMaterial numeric,
	@idUMPeso int,
	@calidadMaterial varchar(20),
	@idTipoMaterial int,
	@idGrupo int,
	@observacionesMaterial varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo material
-- Parametros de salida:
-- Parametros de entrada: @nombreMaterial @usuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiMateriales
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreMaterial
		   ,anchoMaterial
			,idUMAncho
			,largoMaterial
			,idUMLargo
			,pesoMaterial
			,idUMPeso
			,calidadMaterial
			,idTipoMaterial
			,idGrupo
			,observacionesMaterial
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1
           ,@nombreMaterial
		   ,@anchoM
		   ,@idUMAncho
		   ,@largoM
		   ,@idUMLargo
		   ,@pesoMaterial
		   ,@idUMPeso
		   ,@calidadMaterial
		   ,@idTipoMaterial
		   ,@idGrupo
		   ,@observacionesMaterial)
           
           SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMaterialesProyectoM]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarMaterialesProyectoM]	
	@idProyecto int,
	@idEtapa int,
	@idAlmacen int,
	@idMaterial int,
	@idUnidad int,
	@Revision varchar(10),
	@usuario int,
	@idReq int,
	@idDocumento int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo categoria
-- Parametros de salida:
-- Parametros de entrada: @nombreTCategoria 
******************************************
*/
DECLARE @Documento int
BEGIN
	
	SET NOCOUNT ON;

	IF @idDocumento = 0
	BEGIN
 		SELECT @Documento = ISNULL(MAX(documentoMaterialProyecto),0) + 1 FROM cmiMaterialesProyecto
	END
	ELSE
	BEGIN
		SET @Documento = @idDocumento
	END

	IF @idMaterial != '' 
	BEGIN
    INSERT INTO cmiMaterialesProyecto
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idProyecto
		   ,revisionProyecto
		   ,idEtapa
		   ,idAlmacen
		   ,idMaterial
		   ,idOrdenProduccion
		   ,cantidadMaterialProyecto
		   ,idUnidadMedida
		   , documentoMaterialProyecto
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuario
           ,@idProyecto 
           ,@Revision
		   ,@idEtapa
		   ,@idAlmacen
		   ,@idMaterial
		   ,@idEtapa
		   ,0
		   ,@idUnidad
		   ,@Documento)
	END

	IF @idReq != 0
	BEGIN
	DECLARE @idMaterialReq int, @CantReq float, @idUnidadReq int, @idOrigenReq int
	 DECLARE cMain CURSOR 
     FOR  
     
	SELECT dr.idMaterial, 0 cantidadSolicitada, dr.idUnidadMedida, dr.idOrigenRequisicion  FROM cmiRequisiciones re
	inner join cmiDetallesRequisicion dr on re.idRequisicion =  dr.idRequisicion
	where re.idRequisicion  =  @idReq
   OPEN cMain

     FETCH NEXT FROM cMain INTO @idMaterialReq, @CantReq, @idUnidadReq, @idOrigenReq
      WHILE @@FETCH_STATUS = 0
          BEGIN 
         INSERT INTO cmiMaterialesProyecto
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idProyecto
		   ,revisionProyecto
		   ,idEtapa
		   ,idAlmacen
		   ,idMaterial
		   ,idOrdenProduccion
		   ,cantidadMaterialProyecto
		   ,idOrigenRequisicion
		   ,idUnidadMedida
		   ,documentoMaterialProyecto
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuario
           ,@idProyecto 
           ,@Revision
		   ,@idEtapa
		   ,@idAlmacen
		   ,@idMaterialReq
		   ,@idEtapa
		   ,@CantReq
		   ,@idOrigenReq
		   ,@idUnidadReq
		   ,@Documento)
                 

		FETCH NEXT FROM cMain 
			INTO @idMaterialReq, @CantReq, @idUnidadReq, @idOrigenReq
		END
		CLOSE cMain
		DEALLOCATE cMain

END

SELECT @Documento

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMovimientosMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarMovimientosMaterial]	
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarOrdenEmbarque]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarOrdenEmbarque]	
	@idProyecto int,
	@idEtapa int,
	@estatus int,
	@Obser varchar(255),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/Abril/16
-- Descripcion: Insertar un nuevo orden de embarque
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/

BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO cmiOrdenesEmbarque
			(fechaCreacion
			,fechaUltModificacion
			,estatusOrdenEmbarque
			,observacionOrdenEmbarque
			,idProyecto
			,idEtapa
			,idOrdenProduccion
			,usuarioCreacion
			)
		VALUES
			(GETDATE()
			,GETDATE()
			,@estatus
			,@Obser 
			,@idProyecto
			,@idEtapa
			,@idEtapa
			,@usuarioCreacion
			);

	SELECT SCOPE_IDENTITY();

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarOrigenReq]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_InsertarOrigenReq]	
	@nombreOrigenRequisicion varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Origen
-- Parametros de salida:
-- Parametros de entrada: @nombreOrigenRequisicion   @usuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiOrigenesRequisicion
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreOrigenRequisicion
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1 
           ,@nombreOrigenRequisicion)
           
           SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarPlanoDespiece]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarPlanoDespiece]
	@idEstatus int,
	@nombrePlanoDespiece varchar(50),	
	@codigoPlanoDespiece varchar(50),
	@infoGeneral varchar(250),
	@archivoPlanoDespiece varchar(100),	
	@idTipoConstruccion int,
	@idPlanoMontaje int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/Febrero/16
-- Descripcion: Insertar un nuevo Plano Despiece
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;

	INSERT INTO [cmiPlanosDespiece]
			   ([fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[idEstatus]
			   ,[idPlanoMontaje]
			   ,[codigoPlanoDespiece]
			   ,[nombrePlanoDespiece]
			   ,[idTipoConstruccion]
			   ,[infGeneralPlanoDespiece]
			   ,[archivoPlanoDespiece]
			   ,[usuarioCreacion])
		 VALUES
			   (GETDATE()
			   ,GETDATE()
			   ,@idEstatus
			   ,@idPlanoMontaje
			   ,@codigoPlanoDespiece
			   ,@nombrePlanoDespiece
			   ,@idTipoConstruccion
			   ,@infoGeneral
			   ,@archivoPlanoDespiece
			   ,@usuarioCreacion)

		SELECT SCOPE_IDENTITY()

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarPlanoMontaje]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarPlanoMontaje]
	@idEstatus int,
	@nombrePlanoMontaje varchar(50),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@codigoPlanoMontaje varchar(20),
	@infoGeneral varchar(250),
	@archivoPlanoProyecto varchar(100),
	@idEtapa int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 22/Febrero/16
-- Descripcion: Insertar un nuevo Plano Montaje
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
		
	SET NOCOUNT ON;
	
	INSERT INTO [cmiPlanosMontaje]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[idEtapa]
           ,[codigoPlanoMontaje]
           ,[nombrePlanoMontaje]
           ,[fechaInicioPlanoMontaje]
           ,[fechaFinPlanoMontaje]
           ,[infGeneralPlanoMontaje]
           ,[archivoPlanoMontaje]
           ,[usuarioCreacion])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@idEstatus
           ,@idEtapa
           ,@codigoPlanoMontaje
           ,@nombrePlanoMontaje
           ,convert(datetime, @fechaInicio, 103)
           ,convert(datetime, @fechaFin, 103)
           ,@infoGeneral
           ,@archivoPlanoProyecto
           ,@usuarioCreacion)

		SELECT SCOPE_IDENTITY()

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_InsertarProceso]	
	@Nombre varchar(50),
	@idTipoProceso int,
	@UsuarioCreacion int,
	@claseAvance char(1)
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 10/Febrero/16
-- Descripcion: Insertar un nuevo Proceso
-- Parametros de salida:
-- Parametros de entrada: @Nombre @idTipoProceso @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiProcesos]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreProceso]
           ,[idTipoProceso]
		   ,[claseAvance])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre
           ,@idTipoProceso
		   ,@claseAvance)
           
           SELECT SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarProyecto]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarProyecto]	
	@idEstatusRevision int,
	@nombreProyecto varchar(20),
	@fechaInicio varchar(10),
	@fechaFin varchar(10),
	@codigoProyecto varchar(20),
	@revisionProyecto varchar(3),
	@fechaRevision varchar(10),
	@idCategoria int,
	@estatusProyecto int,
	@idCliente int,
	@infoGeneral varchar(250),
	@archivoPlanoProyecto varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 15/Febrero/16
-- Descripcion: Insertar un nuevo Proyecto
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	DECLARE @idProyecto int
	BEGIN TRAN
	SELECT @idProyecto = max(Datos) + 1 
	FROM cmiVarControl
	WHERE Clave = 'TBL' 
	AND Consecutivo = 'PRO'
		
	SET NOCOUNT ON;
	
	INSERT INTO [cmiProyectos]
           ([idProyecto]
           ,[fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatusRevision]
           ,[codigoProyecto]
           ,[revisionProyecto]
           ,[nombreProyecto]
           ,[fechaRevision]
           ,[idCategoria]
           ,[estatusProyecto]
           ,[fechaInicioProyecto]
           ,[fechaFinProyecto]
           ,[idCliente]
           ,[archivoPlanoProyecto]
           ,[infGeneralProyecto]
           ,[usuarioCreacion])
     VALUES
           (@idProyecto
           ,GETDATE()
           ,GETDATE()
           ,@idEstatusRevision
           ,@codigoProyecto
           ,@revisionProyecto
           ,@nombreProyecto
           ,convert(datetime, @fechaRevision, 103)
           ,@idCategoria
           ,@estatusProyecto
           ,convert(datetime, @fechaInicio, 103)
           ,convert(datetime, @fechaFin, 103)
           ,@idCliente
           ,@archivoPlanoProyecto
           ,@infoGeneral
           ,@usuarioCreacion)

    UPDATE cmiVarControl SET Datos = @idProyecto 
	WHERE Clave = 'TBL' 
	AND Consecutivo = 'PRO'
	
	COMMIT
	
	SELECT @idProyecto
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarRemision]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarRemision]	
	@fechaEnvio varchar(10),
	@idCliente int,
	@transporte varchar(100),
	@placas varchar(20),
	@conductor varchar(150),
    @usuarioCreacion int,
	@idProyecto int,
	@idEtapa int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/Abril/16
-- Descripcion: Insertar una nueva Remision
-- Parametros de salida:
-- Parametros de entrada: @fechaEnvio 	@idCliente	@transporte 	@placas 	@conductor  @usuarioCreacion,@idProyecto,@idEtapa
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [cmiRemisiones]
			   ([estatusRemision]
			   ,[usuarioCreacion]
			   ,[fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[fechaRemision]
			   ,[fechaEnvio]
			   ,[transporte]
			   ,[placas]
			   ,[conductor]
			   ,[idCliente]
			   ,[idProyecto]
			   ,[idEtapa])
		 VALUES
			   (1
			   ,@usuarioCreacion
			   ,GETDATE()
			   ,GETDATE()
			   ,GETDATE()
			   ,convert(datetime, @fechaEnvio, 103)
			   ,@transporte
			   ,@placas
			   ,@conductor
			   ,@idCliente
			   ,@idProyecto
			   ,@idEtapa)
			
	SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarRemisionDetalle]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarRemisionDetalle]	
	@idRemision int,
	@idOrdenEmbarque int,
    @usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/Abril/16
-- Descripcion: Insertar el detalle de Ordenes de embarque por la remision
-- Parametros de salida:
-- Parametros de entrada: @idRemision, @idOrdenEmbarque,@usuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiRemisionDetalle]
			   ([idRemision]
			   ,[idOrdenEmbarque]
			   ,[fechaCreacion]
			   ,[idUsuario])
		 VALUES
			   (@idRemision
			   ,@idOrdenEmbarque 
			   ,GETDATE()
			   ,@usuarioCreacion);

	UPDATE cmiOrdenesEmbarque SET
			estatusOrdenEmbarque = 0,
			fechaUltModificacion = Getdate()
	WHERE idOrdenEmbarque = @idOrdenEmbarque;

END


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarRequisicion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarRequisicion] 
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


	/*Se valida si es inicial y que ya sea autorizada*/
	IF @Existe <> 0
	BEGIN
		
		IF (SELECT top 1  req.autorizadoRequisicion
			FROM cmiRequisiciones req
			INNER JOIN cmiDetallesRequisicion re ON req.idRequisicion = re.idRequisicion
			WHERE req.idRequerimiento = @idRequerimiento
				AND re.idOrigenRequisicion = @idOrigenRequisicion
				AND re.idRequisicion = @idRequisicion) = 1
		BEGIN
			SELECT '-3'; /*'La requisicion esta aprobado y no puede ser modificada'; */
			return;
		END
	END

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

				SET @IdReq = SCOPE_IDENTITY()
			END
		END

		IF @Existe <> 0
		BEGIN
			SELECT @IdReq = req.idRequisicion -- @IdReq = 59
			FROM cmiRequisiciones req
			INNER JOIN cmiDetallesRequisicion re ON req.idRequisicion = re.idRequisicion
			WHERE idRequerimiento = @idRequerimiento
				AND re.idOrigenRequisicion = 1;

			IF (SELECT TOP 1  autorizadoRequisicion
				FROM cmiRequisiciones req
				WHERE req.idRequisicion = @IdReq) = 1
			BEGIN
				SELECT '-3'; /*'La requisicion esta aprobado y no puede ser modificada'; */
				return;
			END
		END

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

					SET @IdReq = SCOPE_IDENTITY()
			END

			IF @idRequisicion <> 0 
			BEGIN 
				SET @IdReq = @idRequisicion
			END

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
/****** Object:  StoredProcedure [dbo].[usp_InsertarRutaFabricacion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_InsertarRutaFabricacion]	
	@idCategoria int,
	@secuencia int,
	@idProceso int,
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/16
-- Descripcion: Insertar un nuevo Proceso
-- Parametros de salida:
-- Parametros de entrada: @idCategoria @secuencia @idProceso @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiRutasFabricacion]
			   ([fechaCreacion]
			   ,[fechaUltModificacion]
			   ,[idEstatus]
			   ,[usuarioCreacion]
			   ,[idCategoria]
			   ,[secuenciaRutaFabricacion]
			   ,[idProceso])
		 VALUES
			   (GETDATE()
			   ,GETDATE()
			   ,1
			   ,@UsuarioCreacion
			   ,@idCategoria
			   ,@secuencia
			   ,@idProceso)
    
	SELECT SCOPE_IDENTITY()
END






GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarSeries]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_InsertarSeries]
	@idMarca int,
	@numPiezas int,
	@idEstatus int,	
	@idUsuarioCreacion int

AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 23/Marzo/16
-- Descripcion: Inser
-- Parametros de salida:
-- Parametros de entrada:
******************************************
*/

DECLARE  @cont int = 1;

BEGIN
		
	SET NOCOUNT ON;

	WHILE @cont < @numPiezas + 1
		BEGIN
		
			INSERT INTO cmiSeries ( idMarca
								   ,idSerie
								   ,idEstatus
								   ,idUsuario )
					VALUES		  ( @idMarca
								   ,[dbo].[ufn_getCodigoSerie] (@cont)
								   ,@idEstatus
								   ,@idUsuarioCreacion);
			SET @cont = @cont + 1;

		END;
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarSubMarca]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarSubMarca]
	@idEstatus int,
	@idMarca int,
	@codigoSubMarca varchar(20),		       
	@perfilSubMarca varchar(50),
	@piezasSubMarca int,
	@corteSubMarca float,
	@longitudSubMarca float,
	@anchoSubMarca float,
	@gradoSubMarca varchar(20),
	@kgmSubMarca float,
	@totalLASubMarca float,
	@pesoSubMarca float,
	@idOrdenProduccion int,        
	@claseSubMarca char(1), 
	@totalSubMarca float,
	@alturaSubMarca float,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 09/Marzo/16
-- Descripcion: Insertar una nueva SubMarca
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/

BEGIN
	


	SET NOCOUNT ON;
		
	INSERT INTO [cmiSubMarcas]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[idMarca]
           ,[codigoSubMarca]
           ,[perfilSubMarca]
           ,[piezasSubMarca]
           ,[corteSubMarca]
           ,[longitudSubMarca]
           ,[anchoSubMarca]
           ,[gradoSubMarca]
           ,[kgmSubMarca]
           ,[totalLASubMarca]
           ,[pesoSubMarca]
		   ,[idOrdenProduccion]
		   ,[claseSubMarca]
		   ,[totalSubMarca]
		   ,[alturaSubMarca]
           ,[usuarioCreacion])
     VALUES
           (getdate()
		   ,getdate()
		   ,@idEstatus
           ,@idMarca
           ,@codigoSubMarca
           ,@perfilSubMarca
           ,@piezasSubMarca
           ,@corteSubMarca
           ,@longitudSubMarca
           ,@anchoSubMarca
           ,@gradoSubMarca
           ,@kgmSubMarca
           ,@totalLASubMarca
           ,@pesoSubMarca
		   ,@idOrdenProduccion
		   ,@claseSubMarca
		   ,@totalSubMarca
		   ,@alturaSubMarca
           ,@usuarioCreacion)

		SELECT SCOPE_IDENTITY()

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoCalidad]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarTipoCalidad]	
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de Calidad
-- Parametros de salida:
-- Parametros de entrada: @Nombre
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiTiposCalidad]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreTipoCalidad])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END








GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoConstruccion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarTipoConstruccion]	
	@nombreTipoConstruccion varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de construcción
-- Parametros de salida:
-- Parametros de entrada: @idTipoConstruccion @usuarioCreacion @estatus @nombreTipoConstruccion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiTiposConstruccion
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreTipoConstruccion
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1
           ,@nombreTipoConstruccion)
           
           SELECT SCOPE_IDENTITY()
END




GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarTipoMaterial]	
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de Material
-- Parametros de salida:
-- Parametros de entrada: @Nombre @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiTiposMaterial]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreTipoMaterial])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END







GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoMovtoMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarTipoMovtoMaterial]	
	@nombreTipoMovtoMaterial varchar(100),
	@tipoMovtoMaterial varchar(1),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de movimiento de material
-- Parametros de salida:
-- Parametros de entrada: @usuarioCreacion @estatus @nombreTipoMovtoMaterial @tipoMovtoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiTiposMovtoMaterial
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreTipoMovtoMaterial
		   ,tipoMovtoMaterial
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1
           ,@nombreTipoMovtoMaterial
		   ,@tipoMovtoMaterial)
           
           SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarTipoProceso]	
	@nombreTipoProceso varchar(100),
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Insertar un nuevo Tipo de proceso
-- Parametros de salida:
-- Parametros de entrada: @usuarioCreacion @estatus @nombreTipoProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO cmiTiposProceso
           (fechaCreacion
		   ,fechaUltModificacion
		   ,usuarioCreacion
		   ,idEstatus
		   ,nombreTipoProceso
           )
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@usuarioCreacion
           ,1
           ,@nombreTipoProceso)
           
           SELECT SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarUnidadMedida]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarUnidadMedida]	
	@NombreCorto varchar(5),
	@Nombre varchar(50),
	@UsuarioCreacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/16
-- Descripcion: Insertar un nuevo Unidad de Medida
-- Parametros de salida:
-- Parametros de entrada: @NombreCorto, @Nombre, @UsuarioCreacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO [dbo].[cmiUnidadesMedida]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[usuarioCreacion]
           ,[idEstatus]
           ,[nombreCortoUnidadMedida]
           ,[nombreUnidadMedida])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@NombreCorto
           ,@Nombre)
           
           SELECT SCOPE_IDENTITY()
END






GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarUsuario]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarUsuario]	
	@idEstatus int,
	@Correo varchar(100),
	@Nombre varchar(50),
	@ApePaterno varchar(50),
	@ApeMaterno varchar(50),
	@NombreUsuario varchar(20),
	@Contrasena varchar(20),
	@Puesto varchar(50),
	@Area varchar(50),
	@idDepto int,
	@Autoriza int,
	@idProOrigen int,
	@idProDestino int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/Enero/16
-- Descripcion: Insertar un nuevo Usuario
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	INSERT INTO [cmiUsuarios]
           ([fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[nombreUsuario]
           ,[puestoUsuario]
           ,[areaUsuario]
           ,[idDepartamento]
           ,[emailUsuario]
           ,[loginUsuario]
           ,[passwordUsuario]
           ,[autorizaRequisiciones]
           ,[apePaternoUsuario]
           ,[apeMaternoUsuario]
           ,[idProcesoOrigen]
           ,[idProcesoDestino]
           ,[usuarioCreacion])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@idEstatus
           ,@Nombre
           ,@Puesto
           ,@Area
           ,@idDepto
           ,@Correo
           ,@NombreUsuario 
           ,@Contrasena
           ,@Autoriza
           ,@ApePaterno
           ,@ApeMaterno 
           ,@idProOrigen
           ,@idProDestino
           ,@usuarioCreacion)
           
           SELECT SCOPE_IDENTITY()
END



GO
/****** Object:  StoredProcedure [dbo].[usp_NuevaRevisionProyecto]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery3.sql|7|0|C:\Users\dgalvan\AppData\Local\Temp\~vs76DA.sql
CREATE PROCEDURE [dbo].[usp_NuevaRevisionProyecto]
	@idProyecto int
AS
/*
******************************************
-- Nombre:	David Galvan
-- Fecha: 12/Abril/16
-- Descripcion: Se genera una nueva revision para el proyecto
		Se respalda la informacion del proyecto a tablas historicas
-- Parametros de salida:
-- Parametros de entrada:  @idProyecto
******************************************
*/
DECLARE @revision char(3);
DECLARE @nuevaRevision char(3);
DECLARE @fecha datetime = GETDATE();

BEGIN

 	SET NOCOUNT ON;
	BEGIN TRANSACTION;

	BEGIN TRY

		SELECT @revision = revisionProyecto
		FROM cmiProyectos
		WHERE idProyecto = @idProyecto;
	
		SET @nuevaRevision = RIGHT('000' + CAST(@revision+1 AS NVARCHAR(3)), 3);

		INSERT INTO cmiHisProyectos 
		   (idProyecto, revisionProyecto, fechaCreacion, fechaUltModificacion, 
			idEstatusRevision, codigoProyecto, nombreProyecto, fechaRevision, 
			idCategoria, estatusProyecto, fechaInicioProyecto, fechaFinProyecto, 
			idCliente, archivoPlanoProyecto, infGeneralProyecto, usuarioCreacion)
		SELECT idProyecto, revisionProyecto, fechaCreacion, fechaUltModificacion, 
			idEstatusRevision, codigoProyecto, nombreProyecto, fechaRevision, 
			idCategoria, estatusProyecto, fechaInicioProyecto, fechaFinProyecto, 
			idCliente, archivoPlanoProyecto, infGeneralProyecto, usuarioCreacion
		FROM cmiProyectos
		WHERE idProyecto = @idProyecto;

		INSERT INTO cmiHisEtapas  
				(idEtapa, fechaCreacion, fechaUltModificacion, idEstatus, 
				nombreEtapa, estatusEtapa, fechaInicioEtapa, fechaFinEtapa,
				infGeneralEtapa, usuarioCreacion, claveEtapa, idProyecto, 
				revisionProyecto) 
		SELECT  idEtapa, fechaCreacion, fechaUltModificacion, idEstatus, 
				nombreEtapa, estatusEtapa, fechaInicioEtapa, fechaFinEtapa, 
				infGeneralEtapa, usuarioCreacion, claveEtapa,  idProyecto,
				@revision as revisionProyecto
		FROM cmiEtapas
		WHERE idProyecto = @idProyecto;

		INSERT INTO cmiHisPlanosMontaje
			(idPlanoMontaje, fechaCreacion, fechaUltModificacion, idEstatus, 
			 codigoPlanoMontaje, nombrePlanoMontaje, fechaInicioPlanoMontaje, fechaFinPlanoMontaje, 
			 infGeneralPlanoMontaje, archivoPlanoMontaje, usuarioCreacion, idEtapa, 
			 idProyecto, revisionProyecto)
		SELECT T0.idPlanoMontaje, T0.fechaCreacion, T0.fechaUltModificacion, T0.idEstatus, 
			 T0.codigoPlanoMontaje, T0.nombrePlanoMontaje, T0.fechaInicioPlanoMontaje, T0.fechaFinPlanoMontaje, 
			 T0.infGeneralPlanoMontaje, T0.archivoPlanoMontaje, T0.usuarioCreacion, T0.idEtapa,
			 @idProyecto as idProyecto, @revision as revisionProyecto
		FROM cmiPlanosMontaje T0
		INNER JOIN cmiEtapas T1 ON T1.idEtapa = T0.idEtapa
							   AND T1.IdProyecto = @idProyecto;

		INSERT INTO cmiHisPlanosDespiece 
			(idPlanoDespiece, fechaCreacion, fechaUltModificacion, idEstatus, 
			codigoPlanoDespiece, nombrePlanoDespiece, idTipoConstruccion, infGeneralPlanoDespiece, 
			archivoPlanoDespiece, usuarioCreacion, idPlanoMontaje, idEtapa, 
			idProyecto, revisionProyecto)
		SELECT T0.idPlanoDespiece, T0.fechaCreacion, T0.fechaUltModificacion, T0.idEstatus, 
			T0.codigoPlanoDespiece, T0.nombrePlanoDespiece, T0.idTipoConstruccion, T0.infGeneralPlanoDespiece, 
			T0.archivoPlanoDespiece, T0.usuarioCreacion, T0.idPlanoMontaje,T1.idEtapa,
			@idProyecto as idProyecto, @revision as revisionProyecto
		FROM cmiPlanosDespiece T0
		INNER JOIN cmiPlanosMontaje T1 ON T1.idPlanoMontaje = T0.idPlanoMontaje
		INNER JOIN cmiEtapas T2 ON T2.idEtapa = T1.idEtapa
								AND T2.idProyecto = @idProyecto;

		INSERT INTO cmiHisMarcas 
			(idMarca, fechaCreacion, fechaUltModificacion, idEstatus, 
			codigoMarca, nombreMarca, piezasMarca, pesoMarca,
			usuarioCreacion, idPlanoDespiece, idPlanoMontaje, idEtapa,
			idProyecto, revisionProyecto)
		SELECT T0.idMarca, T0.fechaCreacion, T0.fechaUltModificacion, T0.idEstatus, 
			T0.codigoMarca, T0.nombreMarca, T0.piezasMarca, T0.pesoMarca, 
			T0.usuarioCreacion,T0.idPlanoDespiece, T1.idPlanoMontaje,T2.idEtapa,
			@idProyecto as idProyecto, @revision as revisionProyecto
		FROM cmiMarcas T0
		INNER JOIN cmiPlanosDespiece T1 ON T1.idPlanoDespiece = T0.IdPlanoDespiece
		INNER JOIN cmiPlanosMontaje T2 ON T2.idPlanoMontaje = T1.idPlanoMontaje
		INNER JOIN cmiEtapas T3 ON T3.idEtapa = T2.idEtapa
								and T3.idProyecto = @idProyecto;

		INSERT INTO [cmiHisSeries]
				   ([idSerie]   ,[idEstatusCalidad]   ,[idUsuario]   ,[idProcesoActual]
				   ,[idMarca]   ,[idPlanoDespiece]   ,[idPlanoMontaje]   ,[idEtapa]
				   ,[idProyecto]   ,[revisionProyecto])
		SELECT  T0.[idSerie], T0.[idEstatusCalidad], T0.[idUsuario], T0.[idProcesoActual]
		      , T0.[idMarca],T1.idPlanoDespiece, T2.idPlanoMontaje, T4.idEtapa
			  , @idProyecto as idProyecto, @revision as revisionProyecto
		FROM [cmiSeries] T0
		INNER JOIN cmiMarcas T1 ON T0.idMarca = T1.idMarca
		INNER JOIN cmiPlanosDespiece T2 ON T2.idPlanoDespiece = T1.IdPlanoDespiece
		INNER JOIN cmiPlanosMontaje T3 ON T3.idPlanoMontaje = T2.idPlanoMontaje
		INNER JOIN cmiEtapas T4 ON T4.idEtapa = T3.idEtapa
								and T4.idProyecto = @idProyecto;

		INSERT INTO cmiHisSubMarcas
			(idSubMarca, fechaCreacion, fechaUltModificacion, idEstatusCalidad, 
			codigoSubMarca, perfilSubMarca, piezasSubMarca, corteSubMarca, 
			longitudSubMarca, anchoSubMarca, gradoSubMarca, kgmSubMarca, 
			totalLASubMarca, pesoSubMarca, usuarioCreacion, claseSubMarca, 
			idOrdenProduccion, totalSubMarca, alturaSubMarca, idProcesoActual, 
			idMarca, idPlanoDespiece, idPlanoMontaje, idEtapa, 
			idProyecto, revisionProyecto)
		SELECT T0.idSubMarca, T0.fechaCreacion, T0.fechaUltModificacion, T0.idEstatusCalidad,
			T0.codigoSubMarca, T0.perfilSubMarca, T0.piezasSubMarca, T0.corteSubMarca, 
			T0.longitudSubMarca, T0.anchoSubMarca, T0.gradoSubMarca, T0.kgmSubMarca, 
			T0.totalLASubMarca, T0.pesoSubMarca, T0.usuarioCreacion, T0.claseSubMarca, 
			T0.idOrdenProduccion, T0.totalSubMarca, T0.alturaSubMarca, T0.idProcesoActual,
			T0.idMarca, T1.idPlanoDespiece, T2.idPlanoMontaje,T3.idEtapa,
			@idProyecto as idProyecto, @revision as revisionProyecto
		FROM cmiSubMarcas T0
		INNER JOIN cmiMarcas T1 ON T1.idMarca= T0.idMarca
		INNER JOIN cmiPlanosDespiece T2 ON T2.idPlanoDespiece = T1.IdPlanoDespiece
		INNER JOIN cmiPlanosMontaje T3 ON T3.idPlanoMontaje = T2.idPlanoMontaje
		INNER JOIN cmiEtapas T4 ON T4.idEtapa = T3.idEtapa
								and T4.idProyecto = @idProyecto;

		UPDATE cmiProyectos SET fechaUltModificacion = getdate(),
								revisionProyecto = @nuevaRevision,
								fechaRevision = getdate(),
								idEstatusRevision = 1
		WHERE idProyecto = @idProyecto

		COMMIT TRANSACTION;

		SELECT @nuevaRevision as Revision, 
				convert(varchar(10), getdate(), 103) as Fecha, 
				1 as idEstatus,
				'' as ErrorMessage
		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH;	
END



GO
/****** Object:  StoredProcedure [dbo].[usp_RegistraEmbarque]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RegistraEmbarque]
	@idOrdenEmbarque INT,
	@IdMarca INT,
	@IdSerie NVARCHAR(2),
	@Origen NVARCHAR(2),
	@IdUsuario INT
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 21/Abril/2016
-- Descripcion: Registra el producto en el embarque
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
DECLARE @estatusEntrega int = -1;
DECLARE @estatusEmbarque int = -1;
BEGIN
	
	SET @IdSerie = RIGHT('00' + LTRIM(RTRIM(@IdSerie)), 2)

	SELECT @estatusEntrega = estatusEntrega,
			@estatusEmbarque = estatusEmbarque
	FROM cmiDetalleOrdenEmbarque
	WHERE idOrdenEmbarque = @idOrdenEmbarque
		AND idMarca = @IdMarca
		AND idSerie = @IdSerie;

	IF @Origen = 'EM'
	BEGIN
		IF @estatusEmbarque = 1
		BEGIN
			SELECT 'El codigo seleccionado ya se habia registrado.'
		END
		ELSE
		BEGIN
			IF @estatusEmbarque = -1 
			BEGIN
				SELECT 'El codigo seleccionado no existe.'
			END
			ELSE
			BEGIN
				UPDATE cmiDetalleOrdenEmbarque
				SET estatusEmbarque = 1
				WHERE idOrdenEmbarque = @idOrdenEmbarque
					AND idMarca = @IdMarca
					AND idSerie = @IdSerie;
			END
		END
	END
	ELSE
	BEGIN
		IF @estatusEntrega = 1
		BEGIN
			SELECT 'El codigo seleccionado ya se habia registrado.'
		END
		ELSE
		BEGIN
			IF @estatusEntrega = -1 
			BEGIN
				SELECT 'El codigo seleccionado no existe.'
			END
			ELSE
			BEGIN
				UPDATE cmiDetalleOrdenEmbarque
				SET estatusEntrega = 1
				WHERE idOrdenEmbarque = @idOrdenEmbarque
					AND idMarca = @IdMarca
					AND idSerie = @IdSerie;
			END
		END
	END
END










GO
/****** Object:  StoredProcedure [dbo].[usp_RegistraPermisos]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RegistraPermisos]	
	@idUsuario int,
	@idModulo int,
	@lectura int,
	@escritura int,
	@borrado int,
	@clonado int,
	@idEstatus int,
	@usuarioCreacion int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 03/Febrero/2016
-- Descripcion: Registra la informacion del modulo con el usuario
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	IF ( NOT EXISTS (SELECT idUsuario 
					FROM [cmiPermisos] 
					WHERE [idUsuario] = @idUsuario 
					and  [idModulo] = @idModulo))
    BEGIN      
	
		INSERT INTO [cmiPermisos]
           ([idUsuario]
           ,[idModulo]
           ,[fechaCreacion]
           ,[fechaUltModificacion]
           ,[idEstatus]
           ,[lecturaPermiso]
           ,[escrituraPermiso]
           ,[borradoPermiso]
           ,[clonadoPermiso]
           ,[usuarioCreacion])
     VALUES
           (@idUsuario 
           ,@idModulo
           ,getdate()
           ,getdate()
           ,@idEstatus
           ,@lectura
           ,@escritura
           ,@borrado
           ,@clonado
           ,@usuarioCreacion)
    END
    ELSE
    BEGIN	
		UPDATE [cmiPermisos] SET 
				[fechaUltModificacion] = getdate()
			   ,[idEstatus] = @idEstatus
			   ,[lecturaPermiso] = @lectura
			   ,[escrituraPermiso] = @escritura
			   ,[borradoPermiso] = @borrado
			   ,[clonadoPermiso] = @clonado
		WHERE [idUsuario] = @idUsuario 
		and  [idModulo] = @idModulo
	
	END
END



GO
/****** Object:  StoredProcedure [dbo].[usp_RegistraRepcepRemision]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RegistraRepcepRemision]
	@idOrdenEmb INT,
	@IdMarca INT,
	@IdSerie NVARCHAR(2),
	@idRemision INT,
	@IdUsuario INT
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 25/Abril/2016
-- Descripcion: Registra el producto en la remision
-- Parametros de salida:
-- Parametros de entrada: 
******************************************
*/
DECLARE @estatusEntrega int = -1;

BEGIN
	
	SET @IdSerie = RIGHT('00' + LTRIM(RTRIM(@IdSerie)), 2)

	SELECT @estatusEntrega = Count(idRemision)
	FROM cmiRegistrarRemision
	WHERE idRemision = @idRemision
		AND idOrdenEmbarque = @idOrdenEmb
		AND idMarca = @IdMarca
		AND idSerie = @IdSerie;

		IF @estatusEntrega > 0 
		BEGIN
			SELECT 'El codigo seleccionado ya se habia registrado en la Remision.'
		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[cmiRegistrarRemision]
					   ([idRemision]
					   ,[idOrdenEmbarque]
					   ,[idMarca]
					   ,[idSerie]
					   ,[fechaCreacion]
					   ,[usuarioCreacion])
				 VALUES
					   (@idRemision
					   ,@idOrdenEmb
					   ,@IdMarca
					   ,@IdSerie
					   ,getdate()
					   ,@IdUsuario);
		END
END










GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveAlmacen]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE  PROCEDURE [dbo].[usp_RemueveAlmacen]
	@IdAlmacen int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/2016
-- Descripcion: Se deshabilita el Almacen
-- Parametros de salida:
-- Parametros de entrada: @IdAlmacen
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiAlmacenes
    WHERE idAlmacen = @IdAlmacen

END










GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveCalidadProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[usp_RemueveCalidadProceso]
	@IdProceso int,
	@IdTipoCalidad int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/2016
-- Descripcion: Se deshabilita la CalidadProceso
-- Parametros de salida:
-- Parametros de entrada: @IdProceso @IdTipoCalidad
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiCalidadProceso
    WHERE idProceso = @IdProceso AND idTipoCalidad = @IdTipoCalidad

END












GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveCategoria]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveCategoria]
	@idCategoria int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita la categoria
-- Parametros de salida:
-- Parametros de entrada: @idCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiCategorias
    WHERE idCategoria = @idCategoria 

END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveCliente]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveCliente]
	@idCliente int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el cliente
-- Parametros de salida:
-- Parametros de entrada: @idCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiClientes
    WHERE idCliente = @idCliente

END


GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveDepartamento]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveDepartamento]
	@idDepartamento int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 06 / Febrero /2016
-- Descripcion: Se deshabilita el Departamento
-- Parametros de salida:
-- Parametros de entrada: @idDepartamento
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiDepartamentos
    WHERE idDepartamento = @idDepartamento 

END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveDetalleOrdenEmbarque]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveDetalleOrdenEmbarque]	
	@idOrdenEmbarque int,
	@idMarca int,
	@idSerie char(2),
	@idUsuario int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/Abril/16
-- Descripcion: Remueve detalle de la orden de embarque
-- Parametros de salida:
-- Parametros de entrada:
*******************************************/
BEGIN
	
	SET NOCOUNT ON;

	DELETE [cmiDetalleOrdenEmbarque]
	WHERE [idOrdenEmbarque] = @idOrdenEmbarque
	AND   [idMarca] = @idMarca
	AND   [idSerie] = @idSerie;

END

GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveEtapa]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveEtapa]
	@idEtapa int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 20/ Febrero /2016
-- Descripcion: So borra de base de datos la Etapa
-- Parametros de salida:
-- Parametros de entrada: @idEtapa
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiEtapas
    WHERE idEtapa = @idEtapa
    

END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveGrupo]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE  PROCEDURE [dbo].[usp_RemueveGrupo]
	@IdGrupo int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/2016
-- Descripcion: Se deshabilita el Grupo
-- Parametros de salida:
-- Parametros de entrada: @IdGrupo
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiGrupos
    WHERE idGrupo = @IdGrupo

END









GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveMarca]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveMarca]
	@idMarca int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 01/ Marzo /2016
-- Descripcion: So borra de base de datos la Marca
-- Parametros de salida:
-- Parametros de entrada: @idMarca
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	BEGIN TRANSACTION;

	BEGIN TRY

		DELETE cmiSeries
		WHERE idMarca = @idMarca;

		DELETE cmiMarcas
		WHERE idMarca = @idMarca;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION;
	END CATCH;	
END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveMaterial]
	@idMaterial int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el material
-- Parametros de salida:
-- Parametros de entrada: @idMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiMateriales
    WHERE idMaterial = @idMaterial 

END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveMaterialProyecto]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[usp_RemueveMaterialProyecto]
	@idMaterialAsignado int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el material asignado al proyecto
-- Parametros de salida:
-- Parametros de entrada: @idMaterialAsignado
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiMaterialesProyecto
    WHERE idMaterialProyecto = @idMaterialAsignado 

END


GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveMaterialRequisicion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveMaterialRequisicion]
	@idItem int,
	@idRequisicion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el material de la requisicion
-- Parametros de salida:
-- Parametros de entrada: @idItem @idRequisicion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	if (SELECT autorizadoRequisicion  
		FROM cmiRequisiciones 
		where idRequisicion = @idRequisicion) = 1
	BEGIN
		select '-3';  /*'La requisicion esta aprobado y no puede ser modificada'; */
		return;
	END
	ELSE
	BEGIN

		DELETE cmiDetallesRequisicion
		WHERE idRequisicion = @idRequisicion
		AND idDetalleRequisicion = @idItem;

		select '-1';

	END

END


GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveOrdenEmbarque]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[usp_RemueveOrdenEmbarque]
	@IdOrdenEmbarque int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 01/Abril/2016
-- Descripcion: Se Borra de la base de datos la Orden de Embarque
-- Parametros de salida:
-- Parametros de entrada: @@IdOrdenEmbarque
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiDetalleOrdenEmbarque
    WHERE idOrdenEmbarque = @IdOrdenEmbarque;

	DELETE cmiOrdenesEmbarque
	WHERE idOrdenEmbarque = @IdOrdenEmbarque;

END






GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveOrigenReq]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveOrigenReq]
	@idOrigenRequisicion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el origen de la req
-- Parametros de salida:
-- Parametros de entrada: @idOrigenRequisicion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiOrigenesRequisicion
    WHERE idOrigenRequisicion = @idOrigenRequisicion 

END


GO
/****** Object:  StoredProcedure [dbo].[usp_RemuevePlanoDespiece]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemuevePlanoDespiece]
	@idPlanoDespiece int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 24/ Febrero /2016
-- Descripcion: So borra de base de datos el Plano Despiece
-- Parametros de salida:
-- Parametros de entrada: @idPlanoDespiece
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiPlanosDespiece
    WHERE idPlanoDespiece = @idPlanoDespiece 
    
END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemuevePlanoMontaje]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemuevePlanoMontaje]
	@idPlanoMontaje int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 22/ Febrero /2016
-- Descripcion: So borra de base de datos el Plano montaje
-- Parametros de salida:
-- Parametros de entrada: @idPlanoMontaje
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiPlanosMontaje
    WHERE idPlanoMontaje = @idPlanoMontaje 
    
END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_RemueveProceso]
	@IdProceso int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 10/Febrero/2016
-- Descripcion: Se deshabilita el Proceso
-- Parametros de salida:
-- Parametros de entrada: @IdProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiProcesos
    WHERE idProceso = @IdProceso

END










GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveProyecto]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveProyecto]
	@idProyecto int,
	@revision char(3)
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 17/ Febrero /2016
-- Descripcion: So borra de base de datos el proyecto
-- Parametros de salida:
-- Parametros de entrada: @idProyecto,@revision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiProyectos 
    WHERE idProyecto = @idProyecto 
    and revisionProyecto = @revision

END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveRemision]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create  PROCEDURE [dbo].[usp_RemueveRemision]
	@IdRemision int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 30/Abril/2016
-- Descripcion: Se Borra de la base de datos la Remision
-- Parametros de salida:
-- Parametros de entrada: @IdRemision
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiRemisionDetalle
    WHERE idRemision = @IdRemision;

	DELETE cmiRemisiones
	WHERE idRemision = @IdRemision;

END






GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveRutaFabricacion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_RemueveRutaFabricacion]
	@IdRutaFabricacion int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 12/Febrero/2016
-- Descripcion: Se deshabilita la RutaFabricacion
-- Parametros de salida:
-- Parametros de entrada: @IdRutaFabricacion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiRutasFabricacion
    WHERE idRutaFabricacion = @IdRutaFabricacion

END











GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveSubMarca]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveSubMarca]
	@idSubMarca int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 09/ Marzo /2016
-- Descripcion: So borra de base de datos la SubMarca
-- Parametros de salida:
-- Parametros de entrada: @idSubMarca
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiSubMarcas
    WHERE idSubMarca = @idSubMarca 
    
END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoCalidad]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE  PROCEDURE [dbo].[usp_RemueveTipoCalidad]
	@IdTipoCalidad int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 02/Febrero/2016
-- Descripcion: Se deshabilita el Tipo de Calidad
-- Parametros de salida:
-- Parametros de entrada: @IdTipoCalidad
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposCalidad
    WHERE idTipoCalidad = @IdTipoCalidad

END








GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoConstruccion]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveTipoConstruccion]
	@idTipoConstruccion int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el tipo de construccion
-- Parametros de salida:
-- Parametros de entrada: @idTipoConstruccion
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposConstruccion 
    WHERE idTipoConstruccion = @idTipoConstruccion 

END




GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[usp_RemueveTipoMaterial]
	@IdTipoMaterial int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/2016
-- Descripcion: Se deshabilita el Tipo de Material
-- Parametros de salida:
-- Parametros de entrada: @IdTipoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposMaterial
    WHERE idTipoMaterial = @IdTipoMaterial

END







GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMovtoMaterial]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveTipoMovtoMaterial]
	@idTipoMovtoMaterial int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el tipo de movimiento material
-- Parametros de salida:
-- Parametros de entrada: @idTipoMovtoMaterial
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposMovtoMaterial 
    WHERE idTipoMovtoMaterial = @idTipoMovtoMaterial 

END



GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoProceso]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveTipoProceso]
	@idTipoProceso int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/ FEBRERO /2016
-- Descripcion: Se deshabilita el tipo de proceso
-- Parametros de salida:
-- Parametros de entrada: @idTipoProceso
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiTiposProceso 
    WHERE idTipoProceso = @idTipoProceso

END


GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveUnidadMedida]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[usp_RemueveUnidadMedida]
	@IdUnidadMedida int
AS
/*
******************************************
-- Nombre: Juan Lopepe
-- Fecha: 01/Febrero/2016
-- Descripcion: Se deshabilita la Unidad de Medida
-- Parametros de salida:
-- Parametros de entrada: @IdUnidadMedida
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiUnidadesMedida
    WHERE idUnidadMedida = @IdUnidadMedida

END






GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveUsuario]    Script Date: 01/07/2016 01:19:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_RemueveUsuario]
	@idUsuario int
AS
/*
******************************************
-- Nombre: David Galvan
-- Fecha: 29/ ENERO /2016
-- Descripcion: Se deshabilita el usuario
-- Parametros de salida:
-- Parametros de entrada: @idUsuario
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE cmiUsuarios 
    WHERE idUsuario = @idUsuario 

END



GO
