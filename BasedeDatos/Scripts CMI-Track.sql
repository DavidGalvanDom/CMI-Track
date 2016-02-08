Insert into cmiMenuGrupo VALUES (1,'Usuarios','fa-users',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (2,'General','fa-database',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (3,'Ingenieria','fa-university',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (4,'Requisiciones','fa-file-text',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (5,'Produccion','fa-dashboard',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (6,'Embarque','fa-truck',getdate(),getdate(),1,1)

select * from cmiModulos

INSERT INTO cmiModulos Values (1,getdate(), getdate(),1,'Usuario','Usuario/Index',1)
INSERT INTO cmiModulos Values (2,getdate(), getdate(),1,'Departamento','Departamento/Index',2)
INSERT INTO cmiModulos Values (3,getdate(), getdate(),1,'Permisos','',3)

INSERT INTO cmiModulos Values (4,getdate(), getdate(),1,'Tipo Construccion','TipoConstruccion/Index',1)
INSERT INTO cmiModulos Values (5,getdate(), getdate(),1,'Categoria','Categoria/Index',2)
INSERT INTO cmiModulos Values (6,getdate(), getdate(),1,'Tipo Proceso','TipoProceso/Index',3)
INSERT INTO cmiModulos Values (7,getdate(), getdate(),1,'Procesos','Procesos/Index',4)
INSERT INTO cmiModulos Values (8,getdate(), getdate(),1,'Rutas de Fabricacion','RutasdeFabricacion/Index',5)
INSERT INTO cmiModulos Values (9,getdate(), getdate(),1,'Tipo Material','TipoMaterial/Index',6)
INSERT INTO cmiModulos Values (10,getdate(), getdate(),1,'Unidad de Medida','UnidadMedida/Index',7)
INSERT INTO cmiModulos Values (11,getdate(), getdate(),1,'Calidad','Calidad/Index',8)
INSERT INTO cmiModulos Values (12,getdate(), getdate(),1,'Calidad-Proceso','CalidadProceso/Index',9)
INSERT INTO cmiModulos Values (13,getdate(), getdate(),1,'Grupos Material','Grupo/Index',10)
INSERT INTO cmiModulos Values (14,getdate(), getdate(),1,'Almacen','Almacen/Index',11)
INSERT INTO cmiModulos Values (15,getdate(), getdate(),1,'Materiales','Materiales/Index',12)
INSERT INTO cmiModulos Values (16,getdate(), getdate(),1,'Tipos Movtos Mat','TipoMovtoMaterial/Index',13)
INSERT INTO cmiModulos Values (17,getdate(), getdate(),1,'Clientes','Cliente/Index',14)
INSERT INTO cmiModulos Values (18,getdate(), getdate(),1,'Origen Requisicion','OrigenRequisicion/Index',15)



INSERT INTO cmiModuloMenuGrupo values (1,1)
INSERT INTO cmiModuloMenuGrupo values (1,2)
INSERT INTO cmiModuloMenuGrupo values (1,3)
INSERT INTO cmiModuloMenuGrupo values (2,4)
INSERT INTO cmiModuloMenuGrupo values (2,5)
INSERT INTO cmiModuloMenuGrupo values (2,6)
INSERT INTO cmiModuloMenuGrupo values (2,7)
INSERT INTO cmiModuloMenuGrupo values (2,8)
INSERT INTO cmiModuloMenuGrupo values (2,9)
INSERT INTO cmiModuloMenuGrupo values (2,10)
INSERT INTO cmiModuloMenuGrupo values (2,11)
INSERT INTO cmiModuloMenuGrupo values (2,12)
INSERT INTO cmiModuloMenuGrupo values (2,13)
INSERT INTO cmiModuloMenuGrupo values (2,14)
INSERT INTO cmiModuloMenuGrupo values (2,15)
INSERT INTO cmiModuloMenuGrupo values (2,16)
INSERT INTO cmiModuloMenuGrupo values (2,17)
INSERT INTO cmiModuloMenuGrupo values (2,18)

select * from cmiEstatus

INSERT INTO cmiEstatus Values (0,getdate(), 'Inactivo')
INSERT INTO cmiEstatus Values (1,getdate(), 'Activo')

select * from usuario

INSERT INTO [cmiDepartamentos]([idDepartamento],[fechaCreacion],[fechaUltModificacion]
           ,[usuarioCreacion] ,[idEstatus],[nombreDepartamento]  ,[idUsuario])
     VALUES(1 ,getdate()  ,getdate() ,null ,1 ,'Admin'   ,null)

INSERT INTO [CMITrack].[dbo].[cmiUsuarios]
           ([fechaCreacion] ,[fechaUltModificacion]
           ,[idEstatus] ,[nombreUsuario]
           ,[puestoUsuario] ,[areaUsuario]
           ,[idDepartamento] ,[emailUsuario]
           ,[loginUsuario] ,[passwordUsuario]
           ,[autorizaRequisiciones],[apePaternoUsuario]
           ,[apeMaternoUsuario],[idProcesoOrigen]
           ,[idProcesoDestino])
     VALUES
           (getdate()     ,getdate()
           ,1,'DAVID'
           ,'TEM' ,'AREA'
           ,1 ,'DAVID@HOT.COM'
           ,'DGALVAN'  ,'1'
           ,1 ,'GALVAN'
           ,'DOMIN'  ,NULL
           ,NULL)
GO