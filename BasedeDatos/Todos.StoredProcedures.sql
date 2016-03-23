USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarAlmacen]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCalidadProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCategoria]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCliente]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarDepartamento]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarEtapa]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarGrupo]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarMarca]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarOrigenReq]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarPlanoDespiece]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarPlanoMontaje]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarProceso]
	@IdProceso int,
	@Nombre varchar(50),
	@idTipoProceso int,
	@idEstatus int
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
	 WHERE idProceso = @IdProceso

END





GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarProyecto]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_ActualizarProyecto]	
	@idEstatus int,
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarRequiMateriales]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarRequiMateriales]	
	@idRequerimiento int,
	@idMaterial int,
	@cantidadSolicitada int,
	@Unidad int,
	@idItem int
AS
/*
******************************************
-- Nombre: David Jasso
-- Fecha: 02/Febrero/16
-- Descripcion: Actualiza el material dela requisicion
-- Parametros de salida:
-- Parametros de entrada: @idCategoria @usuarioCreacion @estatus @nombreCategoria
******************************************
*/
BEGIN
	
	SET NOCOUNT ON;
    UPDATE DR
		SET idMaterial = @idMaterial
			,cantidadSolicitada = @cantidadSolicitada
			,idUnidadMedida = @Unidad
	 FROM cmiDetallesRequisicion AS DR
	INNER JOIN cmiRequisiciones R
	ON DR.idRequisicion = R.idRequisicion
	WHERE R.idRequerimiento = @idRequerimiento
	and DR.idDetalleRequisicion = @idItem
END


GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarRutaFabricacion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarSubMarca]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoCalidad]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoConstruccion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMovtoMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUnidadMedida]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUsuario]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_AutentificaUsuario]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_AutorizarRequisicion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_AutorizarRequisicion]
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
/****** Object:  StoredProcedure [dbo].[usp_BuscaLoginUsuario]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarAlmacenes]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarCalidadesProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarCategorias]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarClientes]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarDepartamentos]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarDetalleReqManual]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarDetalleReqManual]
	@item int,
	@idRequerimiento int,
	@Estatus int
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
				T1.cantidadSolicitada,T2.pesoMaterial, T4.nombreCortoUnidadMedida
		FROM cmiRequisiciones T0
			INNER JOIN cmiDetallesRequisicion T1 ON T0.idRequisicion = T1.idRequisicion
			INNER JOIN cmiMateriales T2 ON T1.idMaterial = T2.idMaterial
			INNER JOIN cmiRequerimientos T3 ON T0.idRequerimiento = T3.idRequerimiento
			INNER JOIN cmiUnidadesMedida T4 ON T1.idUnidadMedida = T4.idUnidadMedida
		WHERE t3.idRequerimiento = @idRequerimiento
		and t1.idDetalleRequisicion = ISNULL(@item, t1.idDetalleRequisicion)
			and t0.idEstatus = ISNULL(@Estatus,t0.idEstatus)
		
END
----------------------

GO
/****** Object:  StoredProcedure [dbo].[usp_CargarEtapas]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
  AND T0.[revisionProyecto] = ISNULL(@revisionProyecto,T0.[revisionProyecto])
  AND T0.[estatusEtapa] = ISNULL(@idStatus,T0.[estatusEtapa])
		
END
----------------------


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarExistenciaPlaDes]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarGrupos]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarMarcas]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarMateriales]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
		  ,[idUMAncho]
		  ,[largoMaterial]
		  ,[idUMLargo]
		  ,[pesoMaterial]
		  ,[idUMPeso]
		  ,[calidadMaterial]
		  ,[idTipoMaterial]
		  ,[idGrupo]
		  ,[observacionesMaterial]
		  ,[usuarioCreacion]
  FROM [cmiMateriales] as ma
   inner join cmiEstatus as es on ma.idEstatus = es.idEstatus
   WHERE [idMaterial] = ISNULL(@idMaterial,[idMaterial])
	 and ma.[idEstatus] = ISNULL(@idEstatus,ma.[idEstatus])	
	  
		
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarModulosSeguridad]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
	 	 
		
END
----------------------


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarOrigenReq]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarPlanosDespiece]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarPlanosMontaje]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarProcesos]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_CargarProcesos]
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

	SELECT	 [dbo].[cmiProcesos].[idProceso]
			,[dbo].[cmiProcesos].[fechaCreacion]
			,[dbo].[cmiProcesos].[fechaUltModificacion]
			,[dbo].[cmiProcesos].[usuarioCreacion]
			,[dbo].[cmiProcesos].[idEstatus]
			,[dbo].[cmiEstatus].[nombreEstatus]
			,[dbo].[cmiProcesos].[nombreProceso]
			,[dbo].[cmiProcesos].[idTipoProceso]
			,[dbo].[cmiTiposProceso].[nombreTipoProceso]
	FROM [dbo].[cmiProcesos]
	INNER JOIN [dbo].[cmiEstatus] ON [dbo].[cmiEstatus].[idEstatus] = [dbo].[cmiProcesos].[idEstatus]
	INNER JOIN [dbo].[cmiTiposProceso] ON [dbo].[cmiTiposProceso].[idTipoProceso] = [dbo].[cmiProcesos].[idTipoProceso]
	WHERE [dbo].[cmiProcesos].[idProceso] = ISNULL(@IdProceso, [dbo].[cmiProcesos].[idProceso])
		AND [dbo].[cmiProcesos].[idEstatus] = ISNULL(@IdEstatus, [dbo].[cmiProcesos].[idEstatus])
		
END




GO
/****** Object:  StoredProcedure [dbo].[usp_CargarProyectos]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
      ,T0.[idEstatus]
      ,T1.[nombreEstatus]
      ,T2.[contactoCliente] contactoCliente
      ,T2.[nombreCliente] nombreCliente
      ,T2.[direccionEntregaCliente] direccionCliente      
  FROM [cmiProyectos] T0
  INNER JOIN [cmiEstatus] T1 ON T1.[idEstatus] = T0.[estatusProyecto]
  INNER JOIN [cmiClientes] T2 ON T2.[idCliente] = T0.[idCliente]
  WHERE T0.[idProyecto] = ISNULL(@idProyecto,T0.[idProyecto])
  AND  T0.[revisionProyecto]= ISNULL(@revisionProyecto,T0.[revisionProyecto])
  AND  T0.[estatusProyecto] = ISNULL(@idEstatus, T0.[estatusProyecto])
  

END
----------------------


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRequerimientosGral]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarRequerimientosGral]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarRequerimientosGralId]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarRequerimientosGralId]
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
	
	select sub.idSubMarca
			,sub.perfilSubMarca
			,sub.piezasSubMarca
			,sub.corteSubMarca
			,sub.longitudSubMarca
			,sub.anchoSubMarca
			,sub.gradoSubMarca
			,sub.kgmSubMarca
			,sub.totalLASubMarca
			,sub.pesoSubMarca
		FROM cmiRequerimientos AS re
		INNER JOIN cmiEtapas AS et ON re.idEtapa = et.idEtapa
		INNER JOIN cmiProyectos AS pr ON et.idProyecto = pr.idProyecto
		INNER JOIN cmiOrigenesRequisicion AS ori ON re.idOrigenRequisicion = ori.idOrigenRequisicion
		INNER JOIN cmiDepartamentos AS de ON re.idDepartamento = de.idDepartamento
		INNER JOIN cmiUsuarios AS usu ON re.usuarioSolicita = usu.idUsuario
		INNER JOIN cmiPlanosMontaje AS pm ON et.idEtapa = pm.idEtapa
		INNER JOIN cmiPlanosDespiece AS pd ON pm.idPlanoMontaje = pd.idPlanoMontaje
		INNER JOIN cmiMarcas AS ma ON pd.idPlanoDespiece = ma.idPlanoDespiece
		INNER JOIN cmiSubMarcas AS sub ON ma.idMarca = sub.idMarca
		WHERE idRequerimiento = ISNULL(@idRequerimiento,re.idRequerimiento)
		AND et.idEtapa = ISNULL(@idEtapa,et.idEtapa)
		AND et.idProyecto = ISNULL(@idProyecto,et.idProyecto)
		AND re.idEstatus = ISNULL(@idStatus,re.idEstatus)  

END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRequisiciones]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarRequisiciones]
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

		SELECT rq.idRequisicion
			,ori.nombreOrigenRequisicion
			,rq.causaRequisicion
			,(CASE WHEN rq.autorizadoRequisicion = 1 THEN 'Autorizada' WHEN  rq.autorizadoRequisicion = 0 THEN 'Rechazada' ELSE '' END) AS Estatus
		FROM cmiEtapas AS et
			INNER JOIN cmiProyectos AS pr ON et.idProyecto = pr.idProyecto
			INNER JOIN cmiRequerimientos AS re ON et.idEtapa = re.idEtapa
			INNER JOIN cmiRequisiciones AS rq ON re.idRequerimiento = rq.idRequerimiento
			INNER JOIN cmiOrigenesRequisicion AS ori ON rq.idOrigenRequisicion = ori.idOrigenRequisicion 
		WHERE et.idProyecto = @idProyecto
			AND et.idEtapa = @idEtapa
			AND re.idRequerimiento = @idRequerimiento
			AND re.idEstatus = @idStatus

END


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarRptRequerimiento]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarRptRequerimiento]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarRptRequisicion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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

		SELECT pr.idProyecto
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
/****** Object:  StoredProcedure [dbo].[usp_CargarRutasFabricacion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarSubMarcas]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposCalidad]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposConstruccion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMovtoMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_CargarTiposMovtoMaterial]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarUnidadesMedida]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarioPermisos]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
	ORDER BY T1.ordenModulo
		
END
----------------------


GO
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarios]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarAlmacen]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarCalidadProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarCategoria]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarCliente]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
    @usuarioCreacion int
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
			,1
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarDepartamento]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarEtapa]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarGrupo]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarMarca]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
			,@cont int = 0;
	
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

		COMMIT TRANSACTION;
		SELECT @idMarca;
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION;
	END CATCH;	
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarOrigenReq]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarPlanoDespiece]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarPlanoMontaje]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[usp_InsertarProceso]	
	@Nombre varchar(50),
	@idTipoProceso int,
	@UsuarioCreacion int
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
           ,[idTipoProceso])
     VALUES
           (GETDATE()
           ,GETDATE()
           ,@UsuarioCreacion
           ,1
           ,@Nombre
           ,@idTipoProceso)
           
           SELECT SCOPE_IDENTITY()
END




GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarProyecto]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[usp_InsertarProyecto]	
	@idEstatus int,
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
           ,[idEstatus]
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
           ,@idEstatus
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarRequisicion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarRequisicion]
	@idRequerimiento int,
	@idEstatus int,
	@idOrigenRequisicion int,	
	@idAlmacen int,
	@usuarioCreacion int,
	@idMaterial int,
	@cantidadSolicitada int,
	@causaRequisicion varchar(100),
	@Unidad int

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
DECLARE
@Existe int = 0,
@UltimoID int = 0,
@IdReq int = 0;
BEGIN
		
	SET NOCOUNT ON;

	SELECT @Existe = COUNT(*) FROM cmiRequisiciones
		WHERE idRequerimiento = @idRequerimiento


	IF @Existe = 0  
	BEGIN
		INSERT INTO cmiRequisiciones
			   (fechaCreacion,
				fechaUltModificacion,
				idEstatus,
				causaRequisicion,
				fechaSolicitud,
				idRequerimiento,
				folioRequisicion,
				idOrigenRequisicion,
				idAlmacen,
				usuarioCreacion)
		 VALUES
			   (getdate()
			   ,getdate()
			   ,@idEstatus
			   ,@causaRequisicion
			   ,getdate()
			   ,@idRequerimiento
			   ,@idRequerimiento
			   ,@idOrigenRequisicion
			   ,@idAlmacen
			   ,@usuarioCreacion)
	END
		SELECT @IdReq = idRequisicion FROM cmiRequisiciones
		WHERE idRequerimiento = @idRequerimiento

		SELECT @UltimoID = ISNULL(MAX(T1.idDetalleRequisicion)+1,1) FROM cmiRequisiciones T0
		INNER JOIN cmiDetallesRequisicion T1 ON T0.idRequisicion = T1.idRequisicion
		WHERE T0.idRequerimiento = @idRequerimiento

		INSERT INTO cmiDetallesRequisicion
			   (idRequisicion,
			   idDetalleRequisicion,
				idMaterial,
				cantidadSolicitada,
				idUnidadMedida)
		 VALUES
			   (@IdReq
			   ,@UltimoID
			   ,@idMaterial
			   ,@cantidadSolicitada
			   ,@Unidad)

	

		SELECT @UltimoID

END


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarRutaFabricacion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarSubMarca]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoCalidad]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoConstruccion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoMovtoMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarUnidadMedida]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarUsuario]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RegistraPermisos]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveAlmacen]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveCalidadProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveCategoria]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveCliente]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveDepartamento]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveEtapa]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveGrupo]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveMarca]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveOrigenReq]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemuevePlanoDespiece]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemuevePlanoMontaje]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveProyecto]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveRutaFabricacion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveSubMarca]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoCalidad]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoConstruccion]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMovtoMaterial]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoProceso]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveUnidadMedida]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveUsuario]    Script Date: 23/03/2016 02:00:08 p. m. ******/
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
