USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_CargarProyectos]    Script Date: 24/02/2016 09:11:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------
CREATE PROCEDURE [dbo].[usp_CargarProyectos]
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
      ,convert(varchar(10), T0.[fechaInicioProyecto], 101)  fechaInicioProyecto
      ,convert(varchar(10), T0.[fechaFinProyecto], 101) fechaFinProyecto
      ,convert(varchar(10), T0.[fechaCreacion], 101)  fechaCreacion
      ,convert(varchar(10), T0.[fechaRevision], 101)  fechaRevision
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
