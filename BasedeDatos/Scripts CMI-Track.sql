USE CMITrack
/*	Configuracion inicial
	---------------------
	
	0. Ejecutar 
	-->	Todos.Tablas.sql
	--> Todos.Funciones.sql
	--> Todos.StoredProcedures.sql
	--> Bloques de este archivo
	
	1.  Estatus.
	2.  Departamentos.
	3.  Usuarios.
	4.  VarControl.
	5.  Menus.
	6.  Tipos de Calidad.
	7.  Tipos de Proceso.
	8.  Procesos.
	9.  Calidad Proceso.
	10. Unidades de Medida.
	11. OrigenesRequisicion.
	12. Tipos de Moviemientos para Materiales
	13. Permisos.
*/

BEGIN -- 1. Estatus
	INSERT INTO cmiEstatus VALUES (0, GETDATE(), 'INACTIVO')
	INSERT INTO cmiEstatus VALUES (1, GETDATE(), 'ACTIVO')

	INSERT INTO cmiEstatus VALUES (10, GETDATE(), 'ABIERTO')
	INSERT INTO cmiEstatus VALUES (11, GETDATE(), 'CERRADO')

	INSERT INTO cmiEstatus VALUES (20, GETDATE(),'LIBERADO')
	INSERT INTO cmiEstatus VALUES (21, GETDATE(),'RECHAZADO')
END

BEGIN -- 2. Departamentos
	INSERT INTO cmiDepartamentos (fechaCreacion, fechaUltModificacion, idEstatus, nombreDepartamento, usuarioCreacion)
						VALUES	 (GETDATE(), GETDATE(), 1, 'Admin', null)
END

BEGIN -- 3. Usuarios
	INSERT INTO cmiUsuarios (fechaCreacion, 	fechaUltModificacion, 	idEstatus, 		nombreUsuario, 		puestoUsuario, 			areaUsuario
							,idDepartamento, 	emailUsuario, 			loginUsuario, 	passwordUsuario, 	autorizaRequisiciones,	apePaternoUsuario
							,apeMaternoUsuario,	idProcesoOrigen,		idProcesoDestino)
					VALUES	(GETDATE(), 		GETDATE(), 				1, 				'ADMIN', 			'ADMIN' ,				'ADMIN'
							,1,					'ADMIN@CMI.TRACK.COM'	,'ADMIN',		'1',				1,						'CMI'
							,'TRACK',			NULL,					NULL)
END

BEGIN -- 4. VarControl
	INSERT INTO cmiVarControl VALUES('TBL', 'PRO', '0', 1, GETDATE())
END

BEGIN -- 5. Menus
	--| MENU GRUPO |--
	
	-- SELECT * FROM cmiMenuGrupo
	
	INSERT INTO cmiMenuGrupo VALUES (1,'Usuarios',		'fa-users', 	GETDATE(),GETDATE(),1,1)
	INSERT INTO cmiMenuGrupo VALUES (2,'General',		'fa-database',	GETDATE(),GETDATE(),1,1)
	INSERT INTO cmiMenuGrupo VALUES (3,'Ingenieria',	'fa-university',GETDATE(),GETDATE(),1,1)
	INSERT INTO cmiMenuGrupo VALUES (4,'Requisiciones',	'fa-file-text',	GETDATE(),GETDATE(),1,1)
	INSERT INTO cmiMenuGrupo VALUES (5,'Produccion',	'fa-dashboard',	GETDATE(),GETDATE(),1,1)
	INSERT INTO cmiMenuGrupo VALUES (6,'Embarque',		'fa-truck',		GETDATE(),GETDATE(),1,1)
	
	--| MODULOS |--
	
	-- SELECT * FROM cmiModulos
	--Usuarios
	INSERT INTO cmiModulos VALUES (1, GETDATE(),GETDATE(),1,'Usuario',						'Usuario/Index',				1)
	INSERT INTO cmiModulos VALUES (2, GETDATE(),GETDATE(),1,'Departamento',					'Departamento/Index',			2)
	INSERT INTO cmiModulos VALUES (3, GETDATE(),GETDATE(),1,'Permisos',						'',								3)
	--General
	INSERT INTO cmiModulos VALUES (4,GETDATE(),GETDATE(),1,'Almacen',						'Almacen/Index',				1)
	INSERT INTO cmiModulos VALUES (5,GETDATE(),GETDATE(),1,'Tipo Calidad',					'TipoCalidad/Index',			2)
	INSERT INTO cmiModulos VALUES (6,GETDATE(),GETDATE(),1,'Calidad-Proceso',				'CalidadProceso/Index',			3)
	INSERT INTO cmiModulos VALUES (7,GETDATE(),GETDATE(),1,'Categoria',						'Categoria/Index',				4)
	INSERT INTO cmiModulos VALUES (8,GETDATE(),GETDATE(),1,'Clientes',						'Cliente/Index',				5)
	INSERT INTO cmiModulos VALUES (9,GETDATE(),GETDATE(),1,'Grupos Material',				'Grupo/Index',					6)
	INSERT INTO cmiModulos VALUES (10,GETDATE(),GETDATE(),1,'Materiales',					'Material/Index',				7)
	INSERT INTO cmiModulos VALUES (11,GETDATE(),GETDATE(),1,'Origen Requisicion',			'OrigenRequisicion/Index',		8)
	INSERT INTO cmiModulos VALUES (12,GETDATE(),GETDATE(),1,'Procesos',						'Proceso/Index',				9)
	INSERT INTO cmiModulos VALUES (13,GETDATE(),GETDATE(),1,'Rutas de Fabricacion', 		'RutaFabricacion/Index',		10)
	INSERT INTO cmiModulos VALUES (14,GETDATE(),GETDATE(),1,'Tipo Construccion',			'TipoConstruccion/Index',		11)
	INSERT INTO cmiModulos VALUES (15,GETDATE(),GETDATE(),1,'Tipo Proceso',					'TipoProceso/Index',			12)
	INSERT INTO cmiModulos VALUES (16,GETDATE(),GETDATE(),1,'Tipo Material',				'TipoMaterial/Index',			13)
	INSERT INTO cmiModulos VALUES (17,GETDATE(),GETDATE(),1,'Tipos Movtos Mat',				'TipoMovtoMaterial/Index',		14)
	INSERT INTO cmiModulos VALUES (18,GETDATE(),GETDATE(),1,'Unidad de Medida',				'UnidadMedida/Index',			15)
	--Ingenieria
	INSERT INTO cmiModulos VALUES (19,GETDATE(),GETDATE(),1,'Proyecto',						'Proyecto/Index',				1)
	INSERT INTO cmiModulos VALUES (20,GETDATE(),GETDATE(),1,'Etapa',						'Etapa/Index',					2)
	INSERT INTO cmiModulos VALUES (21,GETDATE(),GETDATE(),1,'Planos de Montaje',			'PlanosMontaje/Index',			3)
	INSERT INTO cmiModulos VALUES (22,GETDATE(),GETDATE(),1,'Planos Despiece',				'PlanosDespiece/Index',			4)
	INSERT INTO cmiModulos VALUES (23,GETDATE(),GETDATE(),1,'Marcas',						'Marcas/Index',					5)
	INSERT INTO cmiModulos VALUES (24,GETDATE(),GETDATE(),1,'SubMarcas',					'SubMarcas/Index',				6)
	INSERT INTO cmiModulos VALUES (25,GETDATE(),GETDATE(),1,'Lista General',				'ListaGeneral/Index',			7)
	INSERT INTO cmiModulos VALUES (26,GETDATE(),GETDATE(),1,'Generacion de Documentos',			'GenerarDocume/Index',			8)
	--Requisiciones
	INSERT INTO cmiModulos VALUES (27,GETDATE(),GETDATE(),1,'Requerimiento',				'ReqGralMaterial/Index',		1)
	INSERT INTO cmiModulos VALUES (28,GETDATE(),GETDATE(),1,'Requisicion Manual',			'ReqManualCompra/Index',		2)
	INSERT INTO cmiModulos VALUES (29,GETDATE(),GETDATE(),1,'Autorizar Requisicion',		'ReqManualCompra/Autorizar',	3)
	INSERT INTO cmiModulos VALUES (30,GETDATE(),GETDATE(),1,'Recepcion Requisicion Compra',	'RecepcionRequisicion/Index',	4)
	INSERT INTO cmiModulos VALUES (31,GETDATE(),GETDATE(),1,'Asigna Materiales Proyecto',	'AsignaProyecto/Index',			5)
	INSERT INTO cmiModulos VALUES (32,GETDATE(),GETDATE(),1,'Movimientos Materiales',		'MovimientoMaterial/Index',		6)
	INSERT INTO cmiModulos VALUES (33,GETDATE(),GETDATE(),1,'Kardex',						'Kardex/Index',					7)
	INSERT INTO cmiModulos VALUES (55,GETDATE(),GETDATE(),1,'Existencias',					'Existencias/Index',			8)
	--Produccion
	INSERT INTO cmiModulos VALUES (34,GETDATE(),GETDATE(),1,'Orden de Produccion',			'OrdenProduccion/Index',		1)
	INSERT INTO cmiModulos VALUES (35,GETDATE(),GETDATE(),1,'Impresion Codigos Barra',		'ImpresionCodigoBarra/Index',	2)
	INSERT INTO cmiModulos VALUES (36,GETDATE(),GETDATE(),1,'Avance/Registro Calidad',		'Avance/Index',					3)
	INSERT INTO cmiModulos VALUES (37,GETDATE(),GETDATE(),1,'Reportes Produccion',			'ReportesProduccion/Index',		4)
	--Embarque
	INSERT INTO cmiModulos VALUES (38,GETDATE(),GETDATE(),1,'Orden de Embarque',			'OrdenEmbarque/Index',			1)
	INSERT INTO cmiModulos VALUES (39,GETDATE(),GETDATE(),1,'Embarque Tablet 1',			'GenerarEmbarque/Tablet1',		2)
	INSERT INTO cmiModulos VALUES (40,GETDATE(),GETDATE(),1,'Embarque Tablet 2',			'GenerarEmbarque/Tablet2',		3)
	INSERT INTO cmiModulos VALUES (41,GETDATE(),GETDATE(),1,'Remision',						'Remision/Index',				4)
	INSERT INTO cmiModulos VALUES (42,GETDATE(),GETDATE(),1,'Recepcion Remision',			'RecepcionRemision/Index',		5)
	
	
	--| MODULOS - MENU GRUPO |--
	
	-- SELECT * FROM cmiModuloMenuGrupo
	--Usuarios
	INSERT INTO cmiModuloMenuGrupo VALUES (1,1)
	INSERT INTO cmiModuloMenuGrupo VALUES (1,2)
	INSERT INTO cmiModuloMenuGrupo VALUES (1,3)
	--General
	INSERT INTO cmiModuloMenuGrupo VALUES (2,4)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,5)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,6)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,7)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,8)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,9)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,10)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,11)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,12)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,13)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,14)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,15)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,16)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,17)
	INSERT INTO cmiModuloMenuGrupo VALUES (2,18)
	--Ingenieria
	INSERT INTO cmiModuloMenuGrupo VALUES (3,19)
	INSERT INTO cmiModuloMenuGrupo VALUES (3,20)
	INSERT INTO cmiModuloMenuGrupo VALUES (3,21)
	INSERT INTO cmiModuloMenuGrupo VALUES (3,22)
	INSERT INTO cmiModuloMenuGrupo VALUES (3,23)
	INSERT INTO cmiModuloMenuGrupo VALUES (3,24)
	INSERT INTO cmiModuloMenuGrupo VALUES (3,25)
	INSERT INTO cmiModuloMenuGrupo VALUES (3,26)
	--Requisiciones
	INSERT INTO cmiModuloMenuGrupo VALUES (4,27)
	INSERT INTO cmiModuloMenuGrupo VALUES (4,28)
	INSERT INTO cmiModuloMenuGrupo VALUES (4,29)
	INSERT INTO cmiModuloMenuGrupo VALUES (4,30)
	INSERT INTO cmiModuloMenuGrupo VALUES (4,31)
	INSERT INTO cmiModuloMenuGrupo VALUES (4,32)
	INSERT INTO cmiModuloMenuGrupo VALUES (4,33)
	INSERT INTO cmiModuloMenuGrupo VALUES (4,55)
	--Produccion
	INSERT INTO cmiModuloMenuGrupo VALUES (5,34)
	INSERT INTO cmiModuloMenuGrupo VALUES (5,35)
	INSERT INTO cmiModuloMenuGrupo VALUES (5,36)
	INSERT INTO cmiModuloMenuGrupo VALUES (5,37)
	--Embarque
	INSERT INTO cmiModuloMenuGrupo VALUES (6,38)
	INSERT INTO cmiModuloMenuGrupo VALUES (6,39)
	INSERT INTO cmiModuloMenuGrupo VALUES (6,40)
	INSERT INTO cmiModuloMenuGrupo VALUES (6,41)
	INSERT INTO cmiModuloMenuGrupo VALUES (6,42)
	
END

BEGIN -- 6. Tipos de Calidad
	INSERT INTO cmiTiposCalidad (fechaCreacion,	fechaUltModificacion,	idEstatus,	nombreTipoCalidad,	usuarioCreacion)
						VALUES	(GETDATE(),		GETDATE(),				1,			'LONGITUD',			1),
								(GETDATE(),		GETDATE(),				1,			'BARRENACION',		1),
								(GETDATE(),		GETDATE(),				1,			'PLACA',			1),
								(GETDATE(),		GETDATE(),				1,			'SOLDADURA',		1),
								(GETDATE(),		GETDATE(),				1,			'PINTURA',			1)
END

BEGIN -- 7. Tipos de Proceso
	INSERT INTO cmiTiposProceso (fechaCreacion,	fechaUltModificacion,	idEstatus,	nombreTipoProceso,	usuarioCreacion)
						VALUES	(GETDATE(),		GETDATE(),				1,			'PRODUCTIVO',		1),
								(GETDATE(),		GETDATE(),				1,			'CALIDAD',			1)
END

BEGIN -- 8. Procesos
	INSERT INTO cmiProcesos (fechaCreacion,	fechaUltModificacion,	idEstatus,	nombreProceso,		idTipoProceso,	usuarioCreacion,	claseAvance)
					VALUES	(GETDATE(),		GETDATE(),				1,			'CORTE',			1,				1,					'S'),
							(GETDATE(),		GETDATE(),				1,			'PANTOGRAFO',		1,				1,					'S'),
							(GETDATE(),		GETDATE(),				1,			'ENSAMBLE',			1,				1,					'M'),
							(GETDATE(),		GETDATE(),				1,			'CALIDAD ENSAMBLE',	2,				1,					'M'),
							(GETDATE(),		GETDATE(),				1,			'SOLDADURA',		1,				1,					'M'),
							(GETDATE(),		GETDATE(),				1,			'CALIDAD SOLDADURA',2,				1,					'M'),
							(GETDATE(),		GETDATE(),				1,			'LIMPIEZA',			1,				1,					'M'),
							(GETDATE(),		GETDATE(),				1,			'PINTURA',			1,				1,					'M'),
							(GETDATE(),		GETDATE(),				1,			'EMBARQUE',			2,				1,					'M')
END

BEGIN -- 9. Calidad Proceso
	INSERT INTO cmiCalidadProceso	(idProceso,	idTipoCalidad,	fechaCreacion,	fechaUltModificacion,	secuenciaCalidadProceso,	idEstatus,	usuarioCreacion)
						VALUES		(4,			1,				GETDATE(),		GETDATE(),				1,							1,			1),
									(4,			2,				GETDATE(),		GETDATE(),				2,							1,			1),
									(6,			4,				GETDATE(),		GETDATE(),				1,							1,			1),
									(6,			5,				GETDATE(),		GETDATE(),				2,							1,			1)
									
END

BEGIN -- 10. Unidades de Medida
	INSERT INTO cmiUnidadesMedida	(fechaCreacion,	fechaUltModificacion,	idEstatus,	nombreCortoUnidadMedida,	nombreUnidadMedida,	usuarioCreacion)
							VALUES	(GETDATE(),		GETDATE(),				1,			'M',						'METRO/S',			1),
									(GETDATE(),		GETDATE(),				1,			'KG',						'KILOGRAMO/S',		1),
									(GETDATE(),		GETDATE(),				1,			'PT',						'PIEZA/S',			1)
END

BEGIN -- 11. OrigenesRequisicion

INSERT INTO [cmiOrigenesRequisicion] ([fechaCreacion],[fechaUltModificacion],[idEstatus],[nombreOrigenRequisicion],[usuarioCreacion])
     VALUES (GETDATE(),		 GETDATE(),		1,		'INICIAL',			1 ),
			(GETDATE(),		 GETDATE(),		1,		'COMPLEMENTO',		1 )

END

BEGIN -- 12. Tipos de Movimientos para Materiales

INSERT INTO cmiTiposMovtoMaterial VALUES (getdate(),getdate(),1,'ENTRADA POR ALMACEN','E',1),
                                         (getdate(),getdate(),1,'SALIDA POR ALMACEN','S',1);
END

BEGIN -- 13. Permisos
	INSERT INTO cmiPermisos VALUES (1,1,GETDATE(),GETDATE(),1,1,1,1,1,1)
	INSERT INTO cmiPermisos VALUES (1,2,GETDATE(),GETDATE(),1,1,1,1,1,1)
	INSERT INTO cmiPermisos VALUES (1,3,GETDATE(),GETDATE(),1,1,1,1,1,1)
END
