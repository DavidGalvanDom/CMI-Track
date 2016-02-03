select * from cmiModulos

INSERT INTO cmiModulos Values (1,getdate(), getdate(),1,'Usuario')
INSERT INTO cmiModulos Values (2,getdate(), getdate(),1,'Departamento')
INSERT INTO cmiModulos Values (3,getdate(), getdate(),1,'Permisos')

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