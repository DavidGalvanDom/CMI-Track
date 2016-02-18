INSERT INTO cmiEstatus Values (0,getdate(), 'INACTIVO')
INSERT INTO cmiEstatus Values (1,getdate(), 'ACTIVO')

INSERT INTO cmiEstatus Values (10,getdate(), 'ABIERTO')
INSERT INTO cmiEstatus Values (11,getdate(), 'CERRADO')
GO

INSERT INTO [cmiDepartamentos]([fechaCreacion],[fechaUltModificacion]
            ,[idEstatus],[nombreDepartamento]  ,[usuarioCreacion])
     VALUES(getdate()  ,getdate() ,1 ,'Admin'   ,null)
GO
INSERT INTO [cmiUsuarios]
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

insert into cmiVarControl values('TBL','PRO','0',1,GETDATE())

select * from cmiMenuGrupo

Insert into cmiMenuGrupo VALUES (1,'Usuarios','fa-users',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (2,'General','fa-database',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (3,'Ingenieria','fa-university',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (4,'Requisiciones','fa-file-text',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (5,'Produccion','fa-dashboard',getdate(),getdate(),1,1)
Insert into cmiMenuGrupo VALUES (6,'Embarque','fa-truck',getdate(),getdate(),1,1)


INSERT INTO cmiModulos Values (1,getdate(), getdate(),1,'Usuario','Usuario/Index',1)
INSERT INTO cmiModulos Values (2,getdate(), getdate(),1,'Departamento','Departamento/Index',2)
INSERT INTO cmiModulos Values (3,getdate(), getdate(),1,'Permisos','',3)

INSERT INTO cmiModulos Values (4,getdate(), getdate(),1,'Tipo Construccion','TipoConstruccion/Index',11)
INSERT INTO cmiModulos Values (5,getdate(), getdate(),1,'Categoria','Categoria/Index',4)
INSERT INTO cmiModulos Values (6,getdate(), getdate(),1,'Tipo Proceso','TipoProceso/Index',12)
INSERT INTO cmiModulos Values (7,getdate(), getdate(),1,'Procesos','Proceso/Index',9)
INSERT INTO cmiModulos Values (8,getdate(), getdate(),1,'Rutas de Fabricacion','RutaFabricacion/Index',10)
INSERT INTO cmiModulos Values (9,getdate(), getdate(),1,'Tipo Material','TipoMaterial/Index',13)
INSERT INTO cmiModulos Values (10,getdate(), getdate(),1,'Unidad de Medida','UnidadMedida/Index',15)
INSERT INTO cmiModulos Values (11,getdate(), getdate(),1,'Tipo Calidad','TipoCalidad/Index',2)
INSERT INTO cmiModulos Values (12,getdate(), getdate(),1,'Calidad-Proceso','CalidadProceso/Index',3)
INSERT INTO cmiModulos Values (13,getdate(), getdate(),1,'Grupos Material','Grupo/Index',6)
INSERT INTO cmiModulos Values (14,getdate(), getdate(),1,'Almacen','Almacen/Index',1)
INSERT INTO cmiModulos Values (15,getdate(), getdate(),1,'Materiales','Material/Index',7)
INSERT INTO cmiModulos Values (16,getdate(), getdate(),1,'Tipos Movtos Mat','TipoMovtoMaterial/Index',14)
INSERT INTO cmiModulos Values (17,getdate(), getdate(),1,'Clientes','Cliente/Index',5)
INSERT INTO cmiModulos Values (18,getdate(), getdate(),1,'Origen Requisicion','OrigenRequisicion/Index',8)

INSERT INTO cmiModulos Values (20,getdate(), getdate(),1,'Proyecto','Proyecto/Index',1)
INSERT INTO cmiModulos Values (21,getdate(), getdate(),1,'Etapa','Etapa/Index',2)

select * from cmiModuloMenuGrupo

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
INSERT INTO cmiModuloMenuGrupo values (3,20)
INSERT INTO cmiModuloMenuGrupo values (3,21)
go

INSERT INTO [cmiPermisos] VALUES (1 ,1 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,2 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,3 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,4 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,5 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,6 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,7 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,8 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,9 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,11 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,12 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,13 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,14 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,15 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,16 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,17 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,18 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)
INSERT INTO [cmiPermisos] VALUES (1 ,20 ,getdate(),getdate() ,1,1 ,1,1 ,1 ,1)

GO



