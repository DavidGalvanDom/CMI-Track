USE [CMITrackVer1]
GO
/****** Object:  StoredProcedure [dbo].[usp_RemueveDepartamento]    Script Date: 24/02/2016 09:11:39 p. m. ******/
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
