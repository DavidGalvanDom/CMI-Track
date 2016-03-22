USE [CMITrackVer1]
GO
/****** Object:  Table [dbo].[cmiAlmacenes]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiAlmacenes](
	[idAlmacen] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreAlmacen] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiAlmacenes] PRIMARY KEY CLUSTERED 
(
	[idAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiCalidadProceso]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiCalidadProceso](
	[idProceso] [int] NOT NULL,
	[idTipoCalidad] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[secuenciaCalidadProceso] [int] NULL,
	[idEstatus] [int] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiCalidadProceso] PRIMARY KEY CLUSTERED 
(
	[idProceso] ASC,
	[idTipoCalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiCategorias]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiCategorias](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[usuarioCreacion] [int] NULL,
	[idEstatus] [int] NULL,
	[nombreCategoria] [varchar](50) NULL,
	[idUsuario] [int] NULL,
 CONSTRAINT [XPKcmiCategorias] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiClientes]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiClientes](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreCliente] [varchar](50) NULL,
	[direccionEntregaCliente] [varchar](20) NULL,
	[coloniaCliente] [varchar](20) NULL,
	[cpCliente] [int] NULL,
	[ciudadCliente] [varchar](20) NULL,
	[estadoCliente] [varchar](20) NULL,
	[paisCliente] [varchar](20) NULL,
	[contactoCliente] [char](18) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiClientes] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiDepartamentos]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiDepartamentos](
	[idDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreDepartamento] [varchar](255) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiDepartamentos] PRIMARY KEY CLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiDetallesRequisicion]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiDetallesRequisicion](
	[idRequisicion] [int] NOT NULL,
	[idDetalleRequisicion] [int] NOT NULL,
	[idMaterial] [int] NULL,
	[cantidadSolicitada] [int] NULL,
	[causaRequisicion] [varchar](20) NULL,
	[cantidadRecibida] [int] NULL,
 CONSTRAINT [XPKcmiDetallesRequisicion] PRIMARY KEY CLUSTERED 
(
	[idRequisicion] ASC,
	[idDetalleRequisicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiEstatus]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiEstatus](
	[idEstatus] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[nombreEstatus] [varchar](20) NULL,
 CONSTRAINT [XPKcmiEstatus] PRIMARY KEY CLUSTERED 
(
	[idEstatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiEtapas]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiEtapas](
	[idEtapa] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[idProyecto] [int] NULL,
	[nombreEtapa] [varchar](20) NULL,
	[estatusEtapa] [int] NULL,
	[fechaInicioEtapa] [datetime] NULL,
	[fechaFinEtapa] [datetime] NULL,
	[infGeneralEtapa] [varchar](250) NULL,
	[usuarioCreacion] [int] NULL,
	[revisionProyecto] [char](3) NULL,
	[claveEtapa] [varchar](10) NULL,
 CONSTRAINT [XPKcmiEtapas] PRIMARY KEY CLUSTERED 
(
	[idEtapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiGrupos]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiGrupos](
	[idGrupo] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreGrupo] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiGrupos] PRIMARY KEY CLUSTERED 
(
	[idGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiMarcas]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiMarcas](
	[idMarca] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[idPlanoDespiece] [int] NULL,
	[codigoMarca] [varchar](20) NULL,
	[nombreMarca] [varchar](50) NULL,
	[piezasMarca] [int] NULL,
	[pesoMarca] [float] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiMarcas] PRIMARY KEY CLUSTERED 
(
	[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiMateriales]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiMateriales](
	[idMaterial] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreMaterial] [varchar](20) NULL,
	[anchoMaterial] [int] NULL,
	[idUMAncho] [int] NULL,
	[largoMaterial] [int] NULL,
	[idUMLargo] [int] NULL,
	[pesoMaterial] [int] NULL,
	[idUMPeso] [int] NULL,
	[calidadMaterial] [varchar](20) NULL,
	[idTipoMaterial] [int] NULL,
	[idGrupo] [int] NULL,
	[observacionesMaterial] [varchar](20) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiMateriales] PRIMARY KEY CLUSTERED 
(
	[idMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiMenuGrupo]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiMenuGrupo](
	[idMenuGrupo] [int] NOT NULL,
	[nombreMenuGrupo] [varchar](50) NULL,
	[iconGrupo] [varchar](50) NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[idUsuario] [int] NULL,
 CONSTRAINT [XPKcmidMenuGrupo] PRIMARY KEY CLUSTERED 
(
	[idMenuGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiModuloMenuGrupo]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiModuloMenuGrupo](
	[idMenuGrupo] [int] NOT NULL,
	[idModulo] [int] NOT NULL,
 CONSTRAINT [XPKcmiModuloMenuGrupo] PRIMARY KEY CLUSTERED 
(
	[idMenuGrupo] ASC,
	[idModulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiModulos]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiModulos](
	[idModulo] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreModulo] [varchar](100) NULL,
	[urlModulo] [varchar](100) NULL,
	[ordenModulo] [int] NULL,
 CONSTRAINT [XPKcmiModulos] PRIMARY KEY CLUSTERED 
(
	[idModulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiOrigenesRequisicion]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiOrigenesRequisicion](
	[idOrigenRequisicion] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreOrigenRequisicion] [varchar](20) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiOrigenesRequisicion] PRIMARY KEY CLUSTERED 
(
	[idOrigenRequisicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiPermisos]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiPermisos](
	[usuarioCreacion] [int] NULL,
	[idModulo] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[lecturaPermiso] [int] NULL,
	[escrituraPermiso] [int] NULL,
	[borradoPermiso] [int] NULL,
	[clonadoPermiso] [int] NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [XPKcmiPermisos] PRIMARY KEY CLUSTERED 
(
	[idModulo] ASC,
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiPlanosDespiece]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiPlanosDespiece](
	[idPlanoDespiece] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[idPlanoMontaje] [int] NULL,
	[codigoPlanoDespiece] [varchar](50) NULL,
	[nombrePlanoDespiece] [varchar](50) NULL,
	[idTipoConstruccion] [int] NULL,
	[infGeneralPlanoDespiece] [varchar](250) NULL,
	[archivoPlanoDespiece] [varchar](80) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiPlanosDespiece] PRIMARY KEY CLUSTERED 
(
	[idPlanoDespiece] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiPlanosMontaje]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiPlanosMontaje](
	[idPlanoMontaje] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[idEtapa] [int] NULL,
	[codigoPlanoMontaje] [varchar](20) NULL,
	[nombrePlanoMontaje] [varchar](50) NULL,
	[fechaInicioPlanoMontaje] [datetime] NULL,
	[fechaFinPlanoMontaje] [datetime] NULL,
	[infGeneralPlanoMontaje] [varchar](250) NULL,
	[archivoPlanoMontaje] [varchar](100) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiPlanosMontaje] PRIMARY KEY CLUSTERED 
(
	[idPlanoMontaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiProcesos]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiProcesos](
	[idProceso] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreProceso] [varchar](50) NULL,
	[idTipoProceso] [int] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiProcesos] PRIMARY KEY CLUSTERED 
(
	[idProceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiProyectos]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiProyectos](
	[idProyecto] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[codigoProyecto] [varchar](20) NULL,
	[revisionProyecto] [char](3) NOT NULL,
	[nombreProyecto] [varchar](20) NULL,
	[fechaRevision] [datetime] NULL,
	[idCategoria] [int] NULL,
	[estatusProyecto] [int] NULL,
	[fechaInicioProyecto] [datetime] NULL,
	[fechaFinProyecto] [datetime] NULL,
	[idCliente] [int] NULL,
	[archivoPlanoProyecto] [varchar](100) NULL,
	[infGeneralProyecto] [varchar](250) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiProyectos] PRIMARY KEY CLUSTERED 
(
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiRequerimientos]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiRequerimientos](
	[idRequerimiento] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[folioRequerimiento] [varchar](20) NULL,
	[fechaSolicitud] [datetime] NULL,
	[idOrigenRequisicion] [int] NULL,
	[idDepartamento] [int] NULL,
	[usuarioSolicita] [int] NULL,
	[idEtapa] [int] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiRequerimientos] PRIMARY KEY CLUSTERED 
(
	[idRequerimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiRequisiciones]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiRequisiciones](
	[idRequisicion] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[folioRequisicion] [varchar](20) NULL,
	[fechaSolicitud] [datetime] NULL,
	[idRequerimiento] [int] NULL,
	[idOrigenRequisicion] [int] NULL,
	[idAlmacen] [int] NULL,
	[autorizadoRequisicion] [int] NULL,
	[usuarioAutoriza] [int] NULL,
	[fechaRecepcion] [datetime] NULL,
	[serieRequisicion] [varchar](20) NULL,
	[facturaRequisicion] [varchar](20) NULL,
	[proveedorRequisicion] [varchar](20) NULL,
	[fechaFacturaRequisicion] [datetime] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiRequisiciones] PRIMARY KEY CLUSTERED 
(
	[idRequisicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiRutasFabricacion]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiRutasFabricacion](
	[idRutaFabricacion] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[idCategoria] [int] NULL,
	[secuenciaRutaFabricacion] [int] NULL,
	[idProceso] [int] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiRutasFabricacion] PRIMARY KEY CLUSTERED 
(
	[idRutaFabricacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiSubMarcas]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiSubMarcas](
	[idSubMarca] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[idMarca] [int] NULL,
	[perfilSubMarca] [varchar](50) NULL,
	[piezasSubMarca] [int] NULL,
	[corteSubMarca] [float] NULL,
	[longitudSubMarca] [float] NULL,
	[anchoSubMarca] [float] NULL,
	[gradoSubMarca] [varchar](20) NULL,
	[kgmSubMarca] [float] NULL,
	[totalLASubMarca] [float] NULL,
	[pesoSubMarca] [float] NULL,
	[usuarioCreacion] [int] NULL,
	[codigoSubMarca] [varchar](20) NULL,
	[idOrdenProduccion] [int] NULL,
	[claseSubMarca] [char](1) NULL,
	[totalSubMarca] [float] NULL,
	[alturaSubMarca] [float] NULL,
 CONSTRAINT [XPKcmiSubMarcas] PRIMARY KEY CLUSTERED 
(
	[idSubMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiTiposCalidad]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiTiposCalidad](
	[idTipoCalidad] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreTipoCalidad] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiTiposCalidad] PRIMARY KEY CLUSTERED 
(
	[idTipoCalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiTiposConstruccion]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiTiposConstruccion](
	[idTipoConstruccion] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreTipoConstruccion] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiTiposConstruccion] PRIMARY KEY CLUSTERED 
(
	[idTipoConstruccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiTiposMaterial]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiTiposMaterial](
	[idTipoMaterial] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreTipoMaterial] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiTiposMaterial] PRIMARY KEY CLUSTERED 
(
	[idTipoMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiTiposMovtoMaterial]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiTiposMovtoMaterial](
	[idTipoMovtoMaterial] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreTipoMovtoMaterial] [varchar](20) NULL,
	[tipoMovtoMaterial] [varchar](20) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiTiposMovtoMaterial] PRIMARY KEY CLUSTERED 
(
	[idTipoMovtoMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiTiposProceso]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiTiposProceso](
	[idTipoProceso] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreTipoProceso] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiTiposProceso] PRIMARY KEY CLUSTERED 
(
	[idTipoProceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiUnidadesMedida]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiUnidadesMedida](
	[idUnidadMedida] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreCortoUnidadMedida] [varchar](10) NULL,
	[nombreUnidadMedida] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiUnidadesMedida] PRIMARY KEY CLUSTERED 
(
	[idUnidadMedida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiUsuarios]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiUsuarios](
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreUsuario] [varchar](50) NULL,
	[puestoUsuario] [varchar](50) NULL,
	[areaUsuario] [varchar](50) NULL,
	[idDepartamento] [int] NULL,
	[emailUsuario] [varchar](100) NULL,
	[loginUsuario] [varchar](20) NULL,
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[passwordUsuario] [varchar](20) NULL,
	[autorizaRequisiciones] [int] NULL,
	[apePaternoUsuario] [varchar](50) NULL,
	[apeMaternoUsuario] [varchar](50) NULL,
	[idProcesoOrigen] [int] NULL,
	[idProcesoDestino] [int] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiUsuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiVarControl]    Script Date: 21/03/2016 08:37:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiVarControl](
	[Clave] [char](3) NOT NULL,
	[Consecutivo] [char](7) NOT NULL,
	[Datos] [varchar](50) NULL,
	[usuarioCreacion] [int] NULL,
	[fechaCreacion] [datetime] NULL,
 CONSTRAINT [XPKcmiVarControl] PRIMARY KEY CLUSTERED 
(
	[Clave] ASC,
	[Consecutivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[cmiAlmacenes]  WITH CHECK ADD  CONSTRAINT [R_36] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiAlmacenes] CHECK CONSTRAINT [R_36]
GO
ALTER TABLE [dbo].[cmiAlmacenes]  WITH CHECK ADD  CONSTRAINT [R_37] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiAlmacenes] CHECK CONSTRAINT [R_37]
GO
ALTER TABLE [dbo].[cmiCalidadProceso]  WITH CHECK ADD  CONSTRAINT [R_30] FOREIGN KEY([idProceso])
REFERENCES [dbo].[cmiProcesos] ([idProceso])
GO
ALTER TABLE [dbo].[cmiCalidadProceso] CHECK CONSTRAINT [R_30]
GO
ALTER TABLE [dbo].[cmiCalidadProceso]  WITH CHECK ADD  CONSTRAINT [R_31] FOREIGN KEY([idTipoCalidad])
REFERENCES [dbo].[cmiTiposCalidad] ([idTipoCalidad])
GO
ALTER TABLE [dbo].[cmiCalidadProceso] CHECK CONSTRAINT [R_31]
GO
ALTER TABLE [dbo].[cmiCalidadProceso]  WITH CHECK ADD  CONSTRAINT [R_32] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiCalidadProceso] CHECK CONSTRAINT [R_32]
GO
ALTER TABLE [dbo].[cmiCalidadProceso]  WITH CHECK ADD  CONSTRAINT [R_33] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiCalidadProceso] CHECK CONSTRAINT [R_33]
GO
ALTER TABLE [dbo].[cmiCategorias]  WITH CHECK ADD  CONSTRAINT [R_13] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiCategorias] CHECK CONSTRAINT [R_13]
GO
ALTER TABLE [dbo].[cmiCategorias]  WITH CHECK ADD  CONSTRAINT [R_14] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiCategorias] CHECK CONSTRAINT [R_14]
GO
ALTER TABLE [dbo].[cmiClientes]  WITH CHECK ADD  CONSTRAINT [R_48] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiClientes] CHECK CONSTRAINT [R_48]
GO
ALTER TABLE [dbo].[cmiClientes]  WITH CHECK ADD  CONSTRAINT [R_49] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiClientes] CHECK CONSTRAINT [R_49]
GO
ALTER TABLE [dbo].[cmiDepartamentos]  WITH CHECK ADD  CONSTRAINT [R_5] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiDepartamentos] CHECK CONSTRAINT [R_5]
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion]  WITH CHECK ADD  CONSTRAINT [R_85] FOREIGN KEY([idRequisicion])
REFERENCES [dbo].[cmiRequisiciones] ([idRequisicion])
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion] CHECK CONSTRAINT [R_85]
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion]  WITH CHECK ADD  CONSTRAINT [R_86] FOREIGN KEY([idMaterial])
REFERENCES [dbo].[cmiMateriales] ([idMaterial])
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion] CHECK CONSTRAINT [R_86]
GO
ALTER TABLE [dbo].[cmiEtapas]  WITH CHECK ADD  CONSTRAINT [R_57] FOREIGN KEY([estatusEtapa])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiEtapas] CHECK CONSTRAINT [R_57]
GO
ALTER TABLE [dbo].[cmiEtapas]  WITH CHECK ADD  CONSTRAINT [R_58] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiEtapas] CHECK CONSTRAINT [R_58]
GO
ALTER TABLE [dbo].[cmiEtapas]  WITH CHECK ADD  CONSTRAINT [R_59] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiEtapas] CHECK CONSTRAINT [R_59]
GO
ALTER TABLE [dbo].[cmiEtapas]  WITH CHECK ADD  CONSTRAINT [R_60] FOREIGN KEY([idProyecto], [revisionProyecto])
REFERENCES [dbo].[cmiProyectos] ([idProyecto], [revisionProyecto])
GO
ALTER TABLE [dbo].[cmiEtapas] CHECK CONSTRAINT [R_60]
GO
ALTER TABLE [dbo].[cmiGrupos]  WITH CHECK ADD  CONSTRAINT [R_34] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiGrupos] CHECK CONSTRAINT [R_34]
GO
ALTER TABLE [dbo].[cmiGrupos]  WITH CHECK ADD  CONSTRAINT [R_35] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiGrupos] CHECK CONSTRAINT [R_35]
GO
ALTER TABLE [dbo].[cmiMarcas]  WITH CHECK ADD  CONSTRAINT [R_68] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiMarcas] CHECK CONSTRAINT [R_68]
GO
ALTER TABLE [dbo].[cmiMarcas]  WITH CHECK ADD  CONSTRAINT [R_69] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiMarcas] CHECK CONSTRAINT [R_69]
GO
ALTER TABLE [dbo].[cmiMarcas]  WITH CHECK ADD  CONSTRAINT [R_70] FOREIGN KEY([idPlanoDespiece])
REFERENCES [dbo].[cmiPlanosDespiece] ([idPlanoDespiece])
GO
ALTER TABLE [dbo].[cmiMarcas] CHECK CONSTRAINT [R_70]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [R_38] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [R_38]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [R_39] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [R_39]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [R_40] FOREIGN KEY([idUMAncho])
REFERENCES [dbo].[cmiUnidadesMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [R_40]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [R_42] FOREIGN KEY([idUMLargo])
REFERENCES [dbo].[cmiUnidadesMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [R_42]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [R_43] FOREIGN KEY([idUMPeso])
REFERENCES [dbo].[cmiUnidadesMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [R_43]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [R_44] FOREIGN KEY([idTipoMaterial])
REFERENCES [dbo].[cmiTiposMaterial] ([idTipoMaterial])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [R_44]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [R_45] FOREIGN KEY([idGrupo])
REFERENCES [dbo].[cmiGrupos] ([idGrupo])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [R_45]
GO
ALTER TABLE [dbo].[cmiMenuGrupo]  WITH CHECK ADD  CONSTRAINT [R_94] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiMenuGrupo] CHECK CONSTRAINT [R_94]
GO
ALTER TABLE [dbo].[cmiMenuGrupo]  WITH CHECK ADD  CONSTRAINT [R_95] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiMenuGrupo] CHECK CONSTRAINT [R_95]
GO
ALTER TABLE [dbo].[cmiModuloMenuGrupo]  WITH CHECK ADD  CONSTRAINT [R_96] FOREIGN KEY([idMenuGrupo])
REFERENCES [dbo].[cmiMenuGrupo] ([idMenuGrupo])
GO
ALTER TABLE [dbo].[cmiModuloMenuGrupo] CHECK CONSTRAINT [R_96]
GO
ALTER TABLE [dbo].[cmiModuloMenuGrupo]  WITH CHECK ADD  CONSTRAINT [R_97] FOREIGN KEY([idModulo])
REFERENCES [dbo].[cmiModulos] ([idModulo])
GO
ALTER TABLE [dbo].[cmiModuloMenuGrupo] CHECK CONSTRAINT [R_97]
GO
ALTER TABLE [dbo].[cmiModulos]  WITH CHECK ADD  CONSTRAINT [R_7] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiModulos] CHECK CONSTRAINT [R_7]
GO
ALTER TABLE [dbo].[cmiOrigenesRequisicion]  WITH CHECK ADD  CONSTRAINT [R_50] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiOrigenesRequisicion] CHECK CONSTRAINT [R_50]
GO
ALTER TABLE [dbo].[cmiOrigenesRequisicion]  WITH CHECK ADD  CONSTRAINT [R_51] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiOrigenesRequisicion] CHECK CONSTRAINT [R_51]
GO
ALTER TABLE [dbo].[cmiPermisos]  WITH CHECK ADD  CONSTRAINT [R_10] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiPermisos] CHECK CONSTRAINT [R_10]
GO
ALTER TABLE [dbo].[cmiPermisos]  WITH CHECK ADD  CONSTRAINT [R_9] FOREIGN KEY([idModulo])
REFERENCES [dbo].[cmiModulos] ([idModulo])
GO
ALTER TABLE [dbo].[cmiPermisos] CHECK CONSTRAINT [R_9]
GO
ALTER TABLE [dbo].[cmiPermisos]  WITH CHECK ADD  CONSTRAINT [R_92] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiPermisos] CHECK CONSTRAINT [R_92]
GO
ALTER TABLE [dbo].[cmiPermisos]  WITH CHECK ADD  CONSTRAINT [R_93] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiPermisos] CHECK CONSTRAINT [R_93]
GO
ALTER TABLE [dbo].[cmiPlanosDespiece]  WITH CHECK ADD  CONSTRAINT [R_64] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiPlanosDespiece] CHECK CONSTRAINT [R_64]
GO
ALTER TABLE [dbo].[cmiPlanosDespiece]  WITH CHECK ADD  CONSTRAINT [R_65] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiPlanosDespiece] CHECK CONSTRAINT [R_65]
GO
ALTER TABLE [dbo].[cmiPlanosDespiece]  WITH CHECK ADD  CONSTRAINT [R_66] FOREIGN KEY([idPlanoMontaje])
REFERENCES [dbo].[cmiPlanosMontaje] ([idPlanoMontaje])
GO
ALTER TABLE [dbo].[cmiPlanosDespiece] CHECK CONSTRAINT [R_66]
GO
ALTER TABLE [dbo].[cmiPlanosDespiece]  WITH CHECK ADD  CONSTRAINT [R_67] FOREIGN KEY([idTipoConstruccion])
REFERENCES [dbo].[cmiTiposConstruccion] ([idTipoConstruccion])
GO
ALTER TABLE [dbo].[cmiPlanosDespiece] CHECK CONSTRAINT [R_67]
GO
ALTER TABLE [dbo].[cmiPlanosMontaje]  WITH CHECK ADD  CONSTRAINT [R_61] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiPlanosMontaje] CHECK CONSTRAINT [R_61]
GO
ALTER TABLE [dbo].[cmiPlanosMontaje]  WITH CHECK ADD  CONSTRAINT [R_62] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiPlanosMontaje] CHECK CONSTRAINT [R_62]
GO
ALTER TABLE [dbo].[cmiPlanosMontaje]  WITH CHECK ADD  CONSTRAINT [R_63] FOREIGN KEY([idEtapa])
REFERENCES [dbo].[cmiEtapas] ([idEtapa])
GO
ALTER TABLE [dbo].[cmiPlanosMontaje] CHECK CONSTRAINT [R_63]
GO
ALTER TABLE [dbo].[cmiProcesos]  WITH CHECK ADD  CONSTRAINT [R_17] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiProcesos] CHECK CONSTRAINT [R_17]
GO
ALTER TABLE [dbo].[cmiProcesos]  WITH CHECK ADD  CONSTRAINT [R_18] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiProcesos] CHECK CONSTRAINT [R_18]
GO
ALTER TABLE [dbo].[cmiProcesos]  WITH CHECK ADD  CONSTRAINT [R_19] FOREIGN KEY([idTipoProceso])
REFERENCES [dbo].[cmiTiposProceso] ([idTipoProceso])
GO
ALTER TABLE [dbo].[cmiProcesos] CHECK CONSTRAINT [R_19]
GO
ALTER TABLE [dbo].[cmiProyectos]  WITH CHECK ADD  CONSTRAINT [R_52] FOREIGN KEY([estatusProyecto])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiProyectos] CHECK CONSTRAINT [R_52]
GO
ALTER TABLE [dbo].[cmiProyectos]  WITH CHECK ADD  CONSTRAINT [R_53] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiProyectos] CHECK CONSTRAINT [R_53]
GO
ALTER TABLE [dbo].[cmiProyectos]  WITH CHECK ADD  CONSTRAINT [R_54] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[cmiCategorias] ([idCategoria])
GO
ALTER TABLE [dbo].[cmiProyectos] CHECK CONSTRAINT [R_54]
GO
ALTER TABLE [dbo].[cmiProyectos]  WITH CHECK ADD  CONSTRAINT [R_55] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiProyectos] CHECK CONSTRAINT [R_55]
GO
ALTER TABLE [dbo].[cmiProyectos]  WITH CHECK ADD  CONSTRAINT [R_56] FOREIGN KEY([idCliente])
REFERENCES [dbo].[cmiClientes] ([idCliente])
GO
ALTER TABLE [dbo].[cmiProyectos] CHECK CONSTRAINT [R_56]
GO
ALTER TABLE [dbo].[cmiRequerimientos]  WITH CHECK ADD  CONSTRAINT [R_74] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiRequerimientos] CHECK CONSTRAINT [R_74]
GO
ALTER TABLE [dbo].[cmiRequerimientos]  WITH CHECK ADD  CONSTRAINT [R_75] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiRequerimientos] CHECK CONSTRAINT [R_75]
GO
ALTER TABLE [dbo].[cmiRequerimientos]  WITH CHECK ADD  CONSTRAINT [R_76] FOREIGN KEY([idEtapa])
REFERENCES [dbo].[cmiEtapas] ([idEtapa])
GO
ALTER TABLE [dbo].[cmiRequerimientos] CHECK CONSTRAINT [R_76]
GO
ALTER TABLE [dbo].[cmiRequerimientos]  WITH CHECK ADD  CONSTRAINT [R_77] FOREIGN KEY([idOrigenRequisicion])
REFERENCES [dbo].[cmiOrigenesRequisicion] ([idOrigenRequisicion])
GO
ALTER TABLE [dbo].[cmiRequerimientos] CHECK CONSTRAINT [R_77]
GO
ALTER TABLE [dbo].[cmiRequerimientos]  WITH CHECK ADD  CONSTRAINT [R_78] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[cmiDepartamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[cmiRequerimientos] CHECK CONSTRAINT [R_78]
GO
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [R_80] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [R_80]
GO
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [R_82] FOREIGN KEY([idRequerimiento])
REFERENCES [dbo].[cmiRequerimientos] ([idRequerimiento])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [R_82]
GO
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [R_83] FOREIGN KEY([idOrigenRequisicion])
REFERENCES [dbo].[cmiOrigenesRequisicion] ([idOrigenRequisicion])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [R_83]
GO
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [R_84] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[cmiAlmacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [R_84]
GO
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [R_87] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [R_87]
GO
ALTER TABLE [dbo].[cmiRutasFabricacion]  WITH CHECK ADD  CONSTRAINT [R_20] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiRutasFabricacion] CHECK CONSTRAINT [R_20]
GO
ALTER TABLE [dbo].[cmiRutasFabricacion]  WITH CHECK ADD  CONSTRAINT [R_21] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiRutasFabricacion] CHECK CONSTRAINT [R_21]
GO
ALTER TABLE [dbo].[cmiRutasFabricacion]  WITH CHECK ADD  CONSTRAINT [R_22] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[cmiCategorias] ([idCategoria])
GO
ALTER TABLE [dbo].[cmiRutasFabricacion] CHECK CONSTRAINT [R_22]
GO
ALTER TABLE [dbo].[cmiRutasFabricacion]  WITH CHECK ADD  CONSTRAINT [R_23] FOREIGN KEY([idProceso])
REFERENCES [dbo].[cmiProcesos] ([idProceso])
GO
ALTER TABLE [dbo].[cmiRutasFabricacion] CHECK CONSTRAINT [R_23]
GO
ALTER TABLE [dbo].[cmiSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_71] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiSubMarcas] CHECK CONSTRAINT [R_71]
GO
ALTER TABLE [dbo].[cmiSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_72] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiSubMarcas] CHECK CONSTRAINT [R_72]
GO
ALTER TABLE [dbo].[cmiSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_73] FOREIGN KEY([idMarca])
REFERENCES [dbo].[cmiMarcas] ([idMarca])
GO
ALTER TABLE [dbo].[cmiSubMarcas] CHECK CONSTRAINT [R_73]
GO
ALTER TABLE [dbo].[cmiTiposCalidad]  WITH CHECK ADD  CONSTRAINT [R_28] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiTiposCalidad] CHECK CONSTRAINT [R_28]
GO
ALTER TABLE [dbo].[cmiTiposCalidad]  WITH CHECK ADD  CONSTRAINT [R_29] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiTiposCalidad] CHECK CONSTRAINT [R_29]
GO
ALTER TABLE [dbo].[cmiTiposConstruccion]  WITH CHECK ADD  CONSTRAINT [R_11] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiTiposConstruccion] CHECK CONSTRAINT [R_11]
GO
ALTER TABLE [dbo].[cmiTiposConstruccion]  WITH CHECK ADD  CONSTRAINT [R_12] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiTiposConstruccion] CHECK CONSTRAINT [R_12]
GO
ALTER TABLE [dbo].[cmiTiposMaterial]  WITH CHECK ADD  CONSTRAINT [R_24] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiTiposMaterial] CHECK CONSTRAINT [R_24]
GO
ALTER TABLE [dbo].[cmiTiposMaterial]  WITH CHECK ADD  CONSTRAINT [R_25] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiTiposMaterial] CHECK CONSTRAINT [R_25]
GO
ALTER TABLE [dbo].[cmiTiposMovtoMaterial]  WITH CHECK ADD  CONSTRAINT [R_46] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiTiposMovtoMaterial] CHECK CONSTRAINT [R_46]
GO
ALTER TABLE [dbo].[cmiTiposMovtoMaterial]  WITH CHECK ADD  CONSTRAINT [R_47] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiTiposMovtoMaterial] CHECK CONSTRAINT [R_47]
GO
ALTER TABLE [dbo].[cmiTiposProceso]  WITH CHECK ADD  CONSTRAINT [R_15] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiTiposProceso] CHECK CONSTRAINT [R_15]
GO
ALTER TABLE [dbo].[cmiTiposProceso]  WITH CHECK ADD  CONSTRAINT [R_16] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiTiposProceso] CHECK CONSTRAINT [R_16]
GO
ALTER TABLE [dbo].[cmiUnidadesMedida]  WITH CHECK ADD  CONSTRAINT [R_26] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiUnidadesMedida] CHECK CONSTRAINT [R_26]
GO
ALTER TABLE [dbo].[cmiUnidadesMedida]  WITH CHECK ADD  CONSTRAINT [R_27] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiUnidadesMedida] CHECK CONSTRAINT [R_27]
GO
ALTER TABLE [dbo].[cmiUsuarios]  WITH CHECK ADD  CONSTRAINT [departamentoUsuario] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[cmiDepartamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[cmiUsuarios] CHECK CONSTRAINT [departamentoUsuario]
GO
ALTER TABLE [dbo].[cmiUsuarios]  WITH CHECK ADD  CONSTRAINT [R_6] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiUsuarios] CHECK CONSTRAINT [R_6]
GO
ALTER TABLE [dbo].[cmiUsuarios]  WITH CHECK ADD  CONSTRAINT [R_89] FOREIGN KEY([idProcesoOrigen])
REFERENCES [dbo].[cmiProcesos] ([idProceso])
GO
ALTER TABLE [dbo].[cmiUsuarios] CHECK CONSTRAINT [R_89]
GO
ALTER TABLE [dbo].[cmiUsuarios]  WITH CHECK ADD  CONSTRAINT [R_90] FOREIGN KEY([idProcesoDestino])
REFERENCES [dbo].[cmiProcesos] ([idProceso])
GO
ALTER TABLE [dbo].[cmiUsuarios] CHECK CONSTRAINT [R_90]
GO
