USE [CMITrack]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveUsuario]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveUsuario]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarUsuario]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarUsuario]	
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
	
	INSERT INTO [CMITrack].[dbo].[cmiUsuarios]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarios]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarUsuarios]
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
	  ,[idEstatus]      
  FROM [cmiUsuarios]
  WHERE idUsuario = ISNULL(@idUsuario,IdUsuario)
	  
		
END
----------------------
GO
/****** Object:  StoredProcedure [dbo].[usp_BuscaLoginUsuario]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_BuscaLoginUsuario]	
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
/****** Object:  StoredProcedure [dbo].[usp_AutentificaUsuario]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_AutentificaUsuario]
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUsuario]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarUsuario]
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveUnidadMedida]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveUnidadMedida]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarUnidadMedida]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarUnidadMedida]	
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarUnidadMedida]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarUnidadMedida]
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoProceso]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoProceso]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoProceso]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoProceso]	
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
           ,2
           ,@nombreTipoProceso)
           
           SELECT SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoProceso]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoProceso]	
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMovtoMaterial]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoMovtoMaterial]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoMovtoMaterial]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoMovtoMaterial]	
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
           ,2 
           ,@nombreTipoMovtoMaterial
		   ,@tipoMovtoMaterial)
           
           SELECT SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMovtoMaterial]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoMovtoMaterial]	
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoMaterial]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoMaterial]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoMaterial]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoMaterial]	
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoMaterial]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoMaterial]
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoConstruccion]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoConstruccion]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoConstruccion]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoConstruccion]	
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
           ,2 
           ,@nombreTipoConstruccion)
           
           SELECT SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoConstruccion]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoConstruccion]	
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveTipoCalidad]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveTipoCalidad]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarTipoCalidad]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarTipoCalidad]	
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarTipoCalidad]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarTipoCalidad]
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
/****** Object:  StoredProcedure [dbo].[usp_RegistraPermisos]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RegistraPermisos]	
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveDepartamento]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[usp_RemueveDepartamento]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarDepartamento]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarDepartamento]	
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
/****** Object:  StoredProcedure [dbo].[usp_CargarDepartamentos]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarDepartamentos]
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
	
	SELECT [idDepartamento]
		  ,[fechaCreacion]
		  ,[idEstatus]
		  ,[nombreDepartamento]
		  ,[usuarioCreacion]
  FROM [cmiDepartamentos]
   WHERE [idDepartamento] = ISNULL(@idDepartamento,[idDepartamento])
	 and [idEstatus] = ISNULL(@idEstatus,[idEstatus])	
	  
		
END
----------------------
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarDepartamento]    Script Date: 02/08/2016 16:12:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarDepartamento]
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveCliente]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveCliente]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarCliente]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarCliente]	
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
			,2
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCliente]    Script Date: 02/08/2016 16:12:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarCliente]	
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveCategoria]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveCategoria]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarCategoria]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarCategoria]	
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
           ,2 
           ,@nombreTCategoria)
           
           SELECT SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarCategoria]    Script Date: 02/08/2016 16:12:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarCategoria]	
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveAlmacen]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveAlmacen]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarAlmacen]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarAlmacen]	
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarAlmacen]    Script Date: 02/08/2016 16:12:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarAlmacen]
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
/****** Object:  StoredProcedure [dbo].[usp_RemueveGrupo]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RemueveGrupo]
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
/****** Object:  StoredProcedure [dbo].[usp_InsertarGrupo]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarGrupo]	
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
/****** Object:  StoredProcedure [dbo].[usp_ActualizarGrupo]    Script Date: 02/08/2016 16:12:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActualizarGrupo]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarUnidadesMedida]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarUnidadesMedida]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposProceso]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposProceso]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMovtoMaterial]    Script Date: 02/08/2016 16:12:09 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposMaterial]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposMaterial]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposConstruccion]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposConstruccion]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarTiposCalidad]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarTiposCalidad]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarGrupos]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarGrupos]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarClientes]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarClientes]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarCategorias]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarCategorias]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarAlmacenes]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CargarAlmacenes]
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
/****** Object:  StoredProcedure [dbo].[usp_CargarUsuarioPermisos]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarUsuarioPermisos]	
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
/****** Object:  StoredProcedure [dbo].[usp_CargarModulosSeguridad]    Script Date: 02/08/2016 16:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarModulosSeguridad]	
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
