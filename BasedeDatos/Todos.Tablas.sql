USE [CMITrack]
GO
/****** Object:  Table [dbo].[cmiActividadesProduccion]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiActividadesProduccion](
	[idActividad] [int] IDENTITY(1,1) NOT NULL,
	[tipoActividad] [char](1) NOT NULL,
	[claseActividad] [char](1) NOT NULL,
	[idSubmarca] [int] NULL,
	[idMarca] [int] NULL,
	[idSerie] [char](2) NULL,
	[piezasActividad] [int] NOT NULL,
	[fechaActividad] [datetime] NOT NULL,
	[idTipoProceso] [int] NOT NULL,
	[idProceso] [int] NOT NULL,
	[idUsuarioFabrico] [int] NULL,
	[idEstatus_Calidad] [int] NULL,
	[observacionesCalidad] [varchar](max) NULL,
	[longitudCalidad] [int] NULL,
	[barrenacionCalidad] [int] NULL,
	[placaCalidad] [int] NULL,
	[soldaduraCalidad] [int] NULL,
	[pinturaCalidad] [int] NULL,
	[usuarioCreacion] [int] NOT NULL,
 CONSTRAINT [XPKcmiActividades] PRIMARY KEY CLUSTERED 
(
	[idActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiAlmacenes]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiCalidadProceso]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiCategorias]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
 CONSTRAINT [XPKcmiCategorias] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiClientes]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiDepartamentos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiDetalleOrdenEmbarque]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiDetalleOrdenEmbarque](
	[idOrdenEmbarque] [int] NOT NULL,
	[idMarca] [int] NOT NULL,
	[idSerie] [char](2) NOT NULL,
	[estatusEmbarque] [int] NULL,
	[estatusEntrega] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[usurioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiDetalleOrdenEmbarque] PRIMARY KEY CLUSTERED 
(
	[idOrdenEmbarque] ASC,
	[idMarca] ASC,
	[idSerie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiDetalleRequerimiento]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiDetalleRequerimiento](
	[idRequerimiento] [int] NOT NULL,
	[numeroRenglon] [int] NOT NULL,
	[perfilDetalleReq] [varchar](50) NULL,
	[piezasDetalleReq] [int] NULL,
	[cortesDetalleReq] [float] NULL,
	[logitudDetalleReq] [float] NULL,
	[anchoDetalleReq] [float] NULL,
	[gradoDetalleReq] [varchar](20) NULL,
	[kgmDetalleReq] [float] NULL,
	[totalLADetalleReq] [float] NULL,
	[pesoDetalleReq] [float] NULL,
	[areaDetalleReq] [float] NULL,
	[idEstatus] [int] NULL,
	[usuarioCreacion] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
 CONSTRAINT [XPKcmiDetalleRequerimiento] PRIMARY KEY CLUSTERED 
(
	[idRequerimiento] ASC,
	[numeroRenglon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiDetallesRequisicion]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiDetallesRequisicion](
	[idRequisicion] [int] NOT NULL,
	[idDetalleRequisicion] [int] NOT NULL,
	[idMaterial] [int] NOT NULL,
	[cantidadSolicitada] [int] NOT NULL,
	[cantidadRecibida] [int] NULL,
	[idUnidadMedida] [int] NULL,
	[idOrigenRequisicion] [int] NULL,
	[causaRequisicion] [varchar](100) NULL,
 CONSTRAINT [PK__cmiDetal__52CAB894EC172743] PRIMARY KEY CLUSTERED 
(
	[idRequisicion] ASC,
	[idDetalleRequisicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiEstatus]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiEtapas]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiGrupos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiHisEtapas]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiHisEtapas](
	[idEtapa] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[nombreEtapa] [varchar](20) NULL,
	[estatusEtapa] [int] NULL,
	[fechaInicioEtapa] [datetime] NULL,
	[fechaFinEtapa] [datetime] NULL,
	[infGeneralEtapa] [varchar](250) NULL,
	[usuarioCreacion] [int] NULL,
	[claveEtapa] [varchar](10) NULL,
	[idProyecto] [int] NOT NULL,
	[revisionProyecto] [char](3) NOT NULL,
 CONSTRAINT [XPKcmiHisEtapas] PRIMARY KEY CLUSTERED 
(
	[idEtapa] ASC,
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiHisMarcas]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiHisMarcas](
	[idMarca] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[codigoMarca] [varchar](20) NULL,
	[nombreMarca] [varchar](50) NULL,
	[piezasMarca] [int] NULL,
	[pesoMarca] [float] NULL,
	[usuarioCreacion] [int] NULL,
	[idPlanoDespiece] [int] NOT NULL,
	[idPlanoMontaje] [int] NOT NULL,
	[idEtapa] [int] NOT NULL,
	[idProyecto] [int] NOT NULL,
	[revisionProyecto] [char](3) NOT NULL,
 CONSTRAINT [XPKcmiHisMarcas] PRIMARY KEY CLUSTERED 
(
	[idMarca] ASC,
	[idPlanoDespiece] ASC,
	[idPlanoMontaje] ASC,
	[idEtapa] ASC,
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiHisPlanosDespiece]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiHisPlanosDespiece](
	[idPlanoDespiece] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[codigoPlanoDespiece] [varchar](50) NULL,
	[nombrePlanoDespiece] [varchar](50) NULL,
	[idTipoConstruccion] [int] NULL,
	[infGeneralPlanoDespiece] [varchar](250) NULL,
	[archivoPlanoDespiece] [varchar](100) NULL,
	[usuarioCreacion] [int] NULL,
	[idPlanoMontaje] [int] NOT NULL,
	[idEtapa] [int] NOT NULL,
	[idProyecto] [int] NOT NULL,
	[revisionProyecto] [char](3) NOT NULL,
 CONSTRAINT [XPKcmiHisPlanosDespiece] PRIMARY KEY CLUSTERED 
(
	[idPlanoDespiece] ASC,
	[idPlanoMontaje] ASC,
	[idEtapa] ASC,
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiHisPlanosMontaje]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiHisPlanosMontaje](
	[idPlanoMontaje] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatus] [int] NULL,
	[codigoPlanoMontaje] [varchar](20) NULL,
	[nombrePlanoMontaje] [varchar](50) NULL,
	[fechaInicioPlanoMontaje] [datetime] NULL,
	[fechaFinPlanoMontaje] [datetime] NULL,
	[infGeneralPlanoMontaje] [varchar](250) NULL,
	[archivoPlanoMontaje] [varchar](100) NULL,
	[usuarioCreacion] [int] NULL,
	[idEtapa] [int] NOT NULL,
	[idProyecto] [int] NOT NULL,
	[revisionProyecto] [char](3) NOT NULL,
 CONSTRAINT [XPKcmiHisPlanosMontaje] PRIMARY KEY CLUSTERED 
(
	[idPlanoMontaje] ASC,
	[idEtapa] ASC,
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiHisProyectos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiHisProyectos](
	[idProyecto] [int] NOT NULL,
	[revisionProyecto] [char](3) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatusRevision] [int] NULL,
	[codigoProyecto] [varchar](20) NULL,
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
 CONSTRAINT [XPKcmiHisProyectos] PRIMARY KEY CLUSTERED 
(
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiHisSeries]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiHisSeries](
	[idSerie] [char](2) NOT NULL,
	[idEstatusCalidad] [int] NULL,
	[idUsuario] [int] NULL,
	[idProcesoActual] [int] NULL,
	[idMarca] [int] NOT NULL,
	[idPlanoDespiece] [int] NOT NULL,
	[idPlanoMontaje] [int] NOT NULL,
	[idEtapa] [int] NOT NULL,
	[idProyecto] [int] NOT NULL,
	[revisionProyecto] [char](3) NOT NULL,
 CONSTRAINT [XPKcmiHisSeries] PRIMARY KEY CLUSTERED 
(
	[idSerie] ASC,
	[idMarca] ASC,
	[idPlanoDespiece] ASC,
	[idPlanoMontaje] ASC,
	[idEtapa] ASC,
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiHisSubMarcas]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiHisSubMarcas](
	[idSubMarca] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[idEstatusCalidad] [int] NULL,
	[codigoSubMarca] [varchar](20) NULL,
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
	[claseSubMarca] [char](1) NULL,
	[idOrdenProduccion] [int] NULL,
	[totalSubMarca] [float] NULL,
	[alturaSubMarca] [float] NULL,
	[idProcesoActual] [int] NULL,
	[idMarca] [int] NOT NULL,
	[idPlanoDespiece] [int] NOT NULL,
	[idPlanoMontaje] [int] NOT NULL,
	[idEtapa] [int] NOT NULL,
	[idProyecto] [int] NOT NULL,
	[revisionProyecto] [char](3) NOT NULL,
 CONSTRAINT [XPKcmiHisSubMarcas] PRIMARY KEY CLUSTERED 
(
	[idSubMarca] ASC,
	[idMarca] ASC,
	[idPlanoDespiece] ASC,
	[idPlanoMontaje] ASC,
	[idEtapa] ASC,
	[idProyecto] ASC,
	[revisionProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiInventarios]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiInventarios](
	[idUsuario] [int] NULL,
	[cantidadInventario] [float] NULL,
	[idMaterial] [int] NOT NULL,
	[idAlmacen] [int] NOT NULL,
	[fechaUltModificacion] [datetime] NULL,
 CONSTRAINT [XPKcmiInventarios] PRIMARY KEY CLUSTERED 
(
	[idMaterial] ASC,
	[idAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiKardex]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiKardex](
	[idKardex] [int] IDENTITY(1,1) NOT NULL,
	[cantidadKardex] [float] NULL,
	[fechaCreacion] [datetime] NULL,
	[usuarioCreacion] [int] NULL,
	[idMaterial] [int] NULL,
	[idAlmacen] [int] NULL,
	[idTipoMovtoMaterial] [int] NULL,
	[documentoKardex] [int] NULL,
 CONSTRAINT [XPKcmiKardex] PRIMARY KEY CLUSTERED 
(
	[idKardex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiMarcas]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiMateriales]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiMateriales](
	[idMaterial] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[fechaUltModificacion] [datetime] NOT NULL,
	[idEstatus] [int] NOT NULL,
	[nombreMaterial] [varchar](20) NOT NULL,
	[anchoMaterial] [int] NOT NULL,
	[idUMAncho] [int] NOT NULL,
	[largoMaterial] [int] NOT NULL,
	[idUMLargo] [int] NOT NULL,
	[pesoMaterial] [int] NOT NULL,
	[idUMPeso] [int] NOT NULL,
	[calidadMaterial] [varchar](20) NOT NULL,
	[idTipoMaterial] [int] NOT NULL,
	[idGrupo] [int] NOT NULL,
	[observacionesMaterial] [varchar](20) NOT NULL,
	[usuarioCreacion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiMaterialesProyecto]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiMaterialesProyecto](
	[idMaterialProyecto] [int] IDENTITY(1,1) NOT NULL,
	[idProyecto] [int] NULL,
	[revisionProyecto] [char](3) NULL,
	[idEtapa] [int] NULL,
	[idAlmacen] [int] NULL,
	[idMaterial] [int] NULL,
	[idOrdenProduccion] [int] NULL,
	[documentoMaterialProyecto] [int] NULL,
	[cantidadMaterialProyecto] [float] NULL,
	[idOrigenRequisicion] [int] NULL,
	[idUnidadMedida] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiMaterialesProyecto] PRIMARY KEY CLUSTERED 
(
	[idMaterialProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiMenuGrupo]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiModuloMenuGrupo]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiModulos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiMovimientosMaterial]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiMovimientosMaterial](
	[idMovimientoMaterial] [int] IDENTITY(1,1) NOT NULL,
	[idMaterial] [int] NOT NULL,
	[idAlmacen] [int] NOT NULL,
	[documentoMovimientoMaterial] [int] NOT NULL,
	[cantidadMovimientoMaterial] [float] NOT NULL,
	[idTipoMovtoMaterial] [int] NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[fechaUltModificacion] [datetime] NOT NULL,
	[usuarioCreacion] [int] NOT NULL,
 CONSTRAINT [XPKcmiMovimientosMaterial] PRIMARY KEY CLUSTERED 
(
	[idMovimientoMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiOrdenesEmbarque]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiOrdenesEmbarque](
	[idOrdenEmbarque] [int] IDENTITY(1,1) NOT NULL,
	[idProyecto] [int] NULL,
	[idEtapa] [int] NULL,
	[idOrdenProduccion] [int] NULL,
	[observacionOrdenEmbarque] [varchar](250) NULL,
	[estatusOrdenEmbarque] [int] NULL,
	[usuarioCreacion] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
 CONSTRAINT [XPKcmiOrdenesEmbarque] PRIMARY KEY CLUSTERED 
(
	[idOrdenEmbarque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiOrigenesRequisicion]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiPermisos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiPlanosDespiece]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
	[archivoPlanoDespiece] [varchar](100) NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiPlanosDespiece] PRIMARY KEY CLUSTERED 
(
	[idPlanoDespiece] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiPlanosMontaje]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiProcesos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
	[claseAvance] [char](1) NULL,
 CONSTRAINT [XPKcmiProcesos] PRIMARY KEY CLUSTERED 
(
	[idProceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiProyectos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
	[idEstatusRevision] [int] NULL,
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
 CONSTRAINT [PK_cmiProyectos] PRIMARY KEY CLUSTERED 
(
	[idProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiRegistrarRemision]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiRegistrarRemision](
	[idRemision] [int] NOT NULL,
	[idOrdenEmbarque] [int] NOT NULL,
	[idMarca] [int] NOT NULL,
	[idSerie] [char](2) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[usuarioCreacion] [int] NULL,
 CONSTRAINT [XPKcmiRegistrarRemision] PRIMARY KEY CLUSTERED 
(
	[idRemision] ASC,
	[idOrdenEmbarque] ASC,
	[idMarca] ASC,
	[idSerie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiRemisionDetalle]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmiRemisionDetalle](
	[idRemision] [int] NOT NULL,
	[idOrdenEmbarque] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[idUsuario] [int] NULL,
 CONSTRAINT [XPKcmiRemisionDetalle] PRIMARY KEY CLUSTERED 
(
	[idRemision] ASC,
	[idOrdenEmbarque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmiRemisiones]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiRemisiones](
	[idRemision] [int] IDENTITY(1,1) NOT NULL,
	[estatusRemision] [int] NULL,
	[usuarioCreacion] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaUltModificacion] [datetime] NULL,
	[fechaRemision] [datetime] NULL,
	[fechaEnvio] [datetime] NULL,
	[transporte] [varchar](100) NULL,
	[placas] [varchar](20) NULL,
	[conductor] [varchar](150) NULL,
	[idCliente] [int] NULL,
	[idProyecto] [int] NULL,
	[idEtapa] [int] NULL,
 CONSTRAINT [XPKcmiRemisiones] PRIMARY KEY CLUSTERED 
(
	[idRemision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiRequerimientos]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiRequerimientos](
	[idRequerimiento] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[cmiRequisiciones]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiRequisiciones](
	[idRequisicion] [int] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[fechaUltModificacion] [datetime] NOT NULL,
	[idEstatus] [int] NOT NULL,
	[folioRequisicion] [varchar](20) NOT NULL,
	[fechaSolicitud] [datetime] NOT NULL,
	[idRequerimiento] [int] NOT NULL,
	[idAlmacen] [int] NOT NULL,
	[autorizadoRequisicion] [int] NULL,
	[usuarioAutoriza] [int] NULL,
	[fechaRecepcion] [datetime] NULL,
	[serieRequisicion] [varchar](20) NULL,
	[facturaRequisicion] [varchar](20) NULL,
	[proveedorRequisicion] [varchar](20) NULL,
	[fechaFacturaRequisicion] [datetime] NULL,
	[usuarioCreacion] [int] NOT NULL,
 CONSTRAINT [PK__cmiRequi__BA875DA3E4D24FB0] PRIMARY KEY CLUSTERED 
(
	[idRequisicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiRutasFabricacion]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiSeries]    Script Date: 30/06/2016 04:03:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cmiSeries](
	[idMarca] [int] NOT NULL,
	[idSerie] [char](2) NOT NULL,
	[idEstatusCalidad] [int] NULL,
	[idUsuario] [int] NULL,
	[idProcesoActual] [int] NULL,
	[idEstatus] [int] NULL,
 CONSTRAINT [XPKcmiSeries] PRIMARY KEY CLUSTERED 
(
	[idMarca] ASC,
	[idSerie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiSubMarcas]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
	[codigoSubMarca] [varchar](20) NULL,
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
	[claseSubMarca] [char](1) NULL,
	[idOrdenProduccion] [int] NULL,
	[totalSubMarca] [float] NULL,
	[alturaSubMarca] [float] NULL,
	[idProcesoActual] [int] NULL,
	[idEstatusCalidad] [int] NULL,
 CONSTRAINT [XPKcmiSubMarcas] PRIMARY KEY CLUSTERED 
(
	[idSubMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmiTiposCalidad]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiTiposConstruccion]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiTiposMaterial]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiTiposMovtoMaterial]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
	[nombreTipoMovtoMaterial] [varchar](100) NULL,
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
/****** Object:  Table [dbo].[cmiTiposProceso]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiUnidadesMedida]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiUsuarios]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
/****** Object:  Table [dbo].[cmiVarControl]    Script Date: 30/06/2016 04:03:56 p. m. ******/
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
ALTER TABLE [dbo].[cmiKardex] ADD  DEFAULT ((0)) FOR [documentoKardex]
GO
ALTER TABLE [dbo].[cmiActividadesProduccion]  WITH CHECK ADD  CONSTRAINT [FK_cmiActividadesProduccion_cmiEstatus] FOREIGN KEY([idEstatus_Calidad])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiActividadesProduccion] CHECK CONSTRAINT [FK_cmiActividadesProduccion_cmiEstatus]
GO
ALTER TABLE [dbo].[cmiActividadesProduccion]  WITH CHECK ADD  CONSTRAINT [FK_cmiActividadesProduccion_cmiProcesos] FOREIGN KEY([idProceso])
REFERENCES [dbo].[cmiProcesos] ([idProceso])
GO
ALTER TABLE [dbo].[cmiActividadesProduccion] CHECK CONSTRAINT [FK_cmiActividadesProduccion_cmiProcesos]
GO
ALTER TABLE [dbo].[cmiActividadesProduccion]  WITH CHECK ADD  CONSTRAINT [FK_cmiActividadesProduccion_cmiSeries] FOREIGN KEY([idMarca], [idSerie])
REFERENCES [dbo].[cmiSeries] ([idMarca], [idSerie])
GO
ALTER TABLE [dbo].[cmiActividadesProduccion] CHECK CONSTRAINT [FK_cmiActividadesProduccion_cmiSeries]
GO
ALTER TABLE [dbo].[cmiActividadesProduccion]  WITH CHECK ADD  CONSTRAINT [FK_cmiActividadesProduccion_cmiSubMarcas] FOREIGN KEY([idSubmarca])
REFERENCES [dbo].[cmiSubMarcas] ([idSubMarca])
GO
ALTER TABLE [dbo].[cmiActividadesProduccion] CHECK CONSTRAINT [FK_cmiActividadesProduccion_cmiSubMarcas]
GO
ALTER TABLE [dbo].[cmiActividadesProduccion]  WITH CHECK ADD  CONSTRAINT [FK_cmiActividadesProduccion_cmiTiposProceso] FOREIGN KEY([idTipoProceso])
REFERENCES [dbo].[cmiTiposProceso] ([idTipoProceso])
GO
ALTER TABLE [dbo].[cmiActividadesProduccion] CHECK CONSTRAINT [FK_cmiActividadesProduccion_cmiTiposProceso]
GO
ALTER TABLE [dbo].[cmiActividadesProduccion]  WITH CHECK ADD  CONSTRAINT [FK_cmiActividadesProduccion_cmiUsuarios] FOREIGN KEY([idUsuarioFabrico])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiActividadesProduccion] CHECK CONSTRAINT [FK_cmiActividadesProduccion_cmiUsuarios]
GO
ALTER TABLE [dbo].[cmiActividadesProduccion]  WITH CHECK ADD  CONSTRAINT [FK_cmiActividadesProduccion_cmiUsuarios1] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiActividadesProduccion] CHECK CONSTRAINT [FK_cmiActividadesProduccion_cmiUsuarios1]
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
ALTER TABLE [dbo].[cmiCategorias]  WITH CHECK ADD  CONSTRAINT [R_14] FOREIGN KEY([usuarioCreacion])
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
ALTER TABLE [dbo].[cmiDetalleOrdenEmbarque]  WITH CHECK ADD  CONSTRAINT [R_176] FOREIGN KEY([idOrdenEmbarque])
REFERENCES [dbo].[cmiOrdenesEmbarque] ([idOrdenEmbarque])
GO
ALTER TABLE [dbo].[cmiDetalleOrdenEmbarque] CHECK CONSTRAINT [R_176]
GO
ALTER TABLE [dbo].[cmiDetalleOrdenEmbarque]  WITH CHECK ADD  CONSTRAINT [R_177] FOREIGN KEY([idMarca], [idSerie])
REFERENCES [dbo].[cmiSeries] ([idMarca], [idSerie])
GO
ALTER TABLE [dbo].[cmiDetalleOrdenEmbarque] CHECK CONSTRAINT [R_177]
GO
ALTER TABLE [dbo].[cmiDetalleOrdenEmbarque]  WITH CHECK ADD  CONSTRAINT [R_178] FOREIGN KEY([usurioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiDetalleOrdenEmbarque] CHECK CONSTRAINT [R_178]
GO
ALTER TABLE [dbo].[cmiDetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [R_105] FOREIGN KEY([idRequerimiento])
REFERENCES [dbo].[cmiRequerimientos] ([idRequerimiento])
GO
ALTER TABLE [dbo].[cmiDetalleRequerimiento] CHECK CONSTRAINT [R_105]
GO
ALTER TABLE [dbo].[cmiDetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [R_106] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiDetalleRequerimiento] CHECK CONSTRAINT [R_106]
GO
ALTER TABLE [dbo].[cmiDetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [R_107] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiDetalleRequerimiento] CHECK CONSTRAINT [R_107]
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion]  WITH NOCHECK ADD  CONSTRAINT [FK__cmiDetall__idMat__123EB7A3] FOREIGN KEY([idMaterial])
REFERENCES [dbo].[cmiMateriales] ([idMaterial])
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion] NOCHECK CONSTRAINT [FK__cmiDetall__idMat__123EB7A3]
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion]  WITH CHECK ADD  CONSTRAINT [FK__cmiDetall__idReq__114A936A] FOREIGN KEY([idRequisicion])
REFERENCES [dbo].[cmiRequisiciones] ([idRequisicion])
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion] CHECK CONSTRAINT [FK__cmiDetall__idReq__114A936A]
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion]  WITH NOCHECK ADD  CONSTRAINT [FK__cmiDetaRequis__idOri__3E1D39E1] FOREIGN KEY([idOrigenRequisicion])
REFERENCES [dbo].[cmiOrigenesRequisicion] ([idOrigenRequisicion])
GO
ALTER TABLE [dbo].[cmiDetallesRequisicion] NOCHECK CONSTRAINT [FK__cmiDetaRequis__idOri__3E1D39E1]
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
ALTER TABLE [dbo].[cmiEtapas]  WITH CHECK ADD  CONSTRAINT [RU_14] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[cmiProyectos] ([idProyecto])
GO
ALTER TABLE [dbo].[cmiEtapas] CHECK CONSTRAINT [RU_14]
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
ALTER TABLE [dbo].[cmiHisEtapas]  WITH CHECK ADD  CONSTRAINT [R_130] FOREIGN KEY([idProyecto], [revisionProyecto])
REFERENCES [dbo].[cmiHisProyectos] ([idProyecto], [revisionProyecto])
GO
ALTER TABLE [dbo].[cmiHisEtapas] CHECK CONSTRAINT [R_130]
GO
ALTER TABLE [dbo].[cmiHisMarcas]  WITH CHECK ADD  CONSTRAINT [R_134] FOREIGN KEY([idPlanoDespiece], [idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
REFERENCES [dbo].[cmiHisPlanosDespiece] ([idPlanoDespiece], [idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
GO
ALTER TABLE [dbo].[cmiHisMarcas] CHECK CONSTRAINT [R_134]
GO
ALTER TABLE [dbo].[cmiHisPlanosDespiece]  WITH CHECK ADD  CONSTRAINT [R_133] FOREIGN KEY([idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
REFERENCES [dbo].[cmiHisPlanosMontaje] ([idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
GO
ALTER TABLE [dbo].[cmiHisPlanosDespiece] CHECK CONSTRAINT [R_133]
GO
ALTER TABLE [dbo].[cmiHisPlanosMontaje]  WITH CHECK ADD  CONSTRAINT [R_131] FOREIGN KEY([idEtapa], [idProyecto], [revisionProyecto])
REFERENCES [dbo].[cmiHisEtapas] ([idEtapa], [idProyecto], [revisionProyecto])
GO
ALTER TABLE [dbo].[cmiHisPlanosMontaje] CHECK CONSTRAINT [R_131]
GO
ALTER TABLE [dbo].[cmiHisSeries]  WITH CHECK ADD  CONSTRAINT [R_160] FOREIGN KEY([idMarca], [idPlanoDespiece], [idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
REFERENCES [dbo].[cmiHisMarcas] ([idMarca], [idPlanoDespiece], [idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
GO
ALTER TABLE [dbo].[cmiHisSeries] CHECK CONSTRAINT [R_160]
GO
ALTER TABLE [dbo].[cmiHisSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_135] FOREIGN KEY([idMarca], [idPlanoDespiece], [idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
REFERENCES [dbo].[cmiHisMarcas] ([idMarca], [idPlanoDespiece], [idPlanoMontaje], [idEtapa], [idProyecto], [revisionProyecto])
GO
ALTER TABLE [dbo].[cmiHisSubMarcas] CHECK CONSTRAINT [R_135]
GO
ALTER TABLE [dbo].[cmiInventarios]  WITH CHECK ADD  CONSTRAINT [R_119] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiInventarios] CHECK CONSTRAINT [R_119]
GO
ALTER TABLE [dbo].[cmiInventarios]  WITH CHECK ADD  CONSTRAINT [R_120] FOREIGN KEY([idMaterial])
REFERENCES [dbo].[cmiMateriales] ([idMaterial])
GO
ALTER TABLE [dbo].[cmiInventarios] CHECK CONSTRAINT [R_120]
GO
ALTER TABLE [dbo].[cmiInventarios]  WITH CHECK ADD  CONSTRAINT [R_121] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[cmiAlmacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[cmiInventarios] CHECK CONSTRAINT [R_121]
GO
ALTER TABLE [dbo].[cmiKardex]  WITH CHECK ADD  CONSTRAINT [R_122] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiKardex] CHECK CONSTRAINT [R_122]
GO
ALTER TABLE [dbo].[cmiKardex]  WITH CHECK ADD  CONSTRAINT [R_123] FOREIGN KEY([idMaterial])
REFERENCES [dbo].[cmiMateriales] ([idMaterial])
GO
ALTER TABLE [dbo].[cmiKardex] CHECK CONSTRAINT [R_123]
GO
ALTER TABLE [dbo].[cmiKardex]  WITH CHECK ADD  CONSTRAINT [R_124] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[cmiAlmacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[cmiKardex] CHECK CONSTRAINT [R_124]
GO
ALTER TABLE [dbo].[cmiKardex]  WITH CHECK ADD  CONSTRAINT [R_125] FOREIGN KEY([idTipoMovtoMaterial])
REFERENCES [dbo].[cmiTiposMovtoMaterial] ([idTipoMovtoMaterial])
GO
ALTER TABLE [dbo].[cmiKardex] CHECK CONSTRAINT [R_125]
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
ALTER TABLE [dbo].[cmiMateriales]  WITH NOCHECK ADD FOREIGN KEY([idGrupo])
REFERENCES [dbo].[cmiGrupos] ([idGrupo])
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH NOCHECK ADD FOREIGN KEY([idTipoMaterial])
REFERENCES [dbo].[cmiTiposMaterial] ([idTipoMaterial])
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH NOCHECK ADD FOREIGN KEY([idUMAncho])
REFERENCES [dbo].[cmiUnidadesMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH NOCHECK ADD FOREIGN KEY([idUMLargo])
REFERENCES [dbo].[cmiUnidadesMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH NOCHECK ADD FOREIGN KEY([idUMPeso])
REFERENCES [dbo].[cmiUnidadesMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH NOCHECK ADD FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [RU_15] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [RU_15]
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto]  WITH CHECK ADD  CONSTRAINT [R_137] FOREIGN KEY([idEtapa])
REFERENCES [dbo].[cmiEtapas] ([idEtapa])
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto] CHECK CONSTRAINT [R_137]
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto]  WITH CHECK ADD  CONSTRAINT [R_138] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[cmiAlmacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto] CHECK CONSTRAINT [R_138]
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto]  WITH CHECK ADD  CONSTRAINT [R_139] FOREIGN KEY([idMaterial])
REFERENCES [dbo].[cmiMateriales] ([idMaterial])
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto] CHECK CONSTRAINT [R_139]
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto]  WITH CHECK ADD  CONSTRAINT [R_140] FOREIGN KEY([idOrigenRequisicion])
REFERENCES [dbo].[cmiOrigenesRequisicion] ([idOrigenRequisicion])
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto] CHECK CONSTRAINT [R_140]
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto]  WITH CHECK ADD  CONSTRAINT [R_141] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto] CHECK CONSTRAINT [R_141]
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto]  WITH CHECK ADD  CONSTRAINT [R_144] FOREIGN KEY([idUnidadMedida])
REFERENCES [dbo].[cmiUnidadesMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[cmiMaterialesProyecto] CHECK CONSTRAINT [R_144]
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
ALTER TABLE [dbo].[cmiMovimientosMaterial]  WITH CHECK ADD  CONSTRAINT [R_145] FOREIGN KEY([idMaterial])
REFERENCES [dbo].[cmiMateriales] ([idMaterial])
GO
ALTER TABLE [dbo].[cmiMovimientosMaterial] CHECK CONSTRAINT [R_145]
GO
ALTER TABLE [dbo].[cmiMovimientosMaterial]  WITH CHECK ADD  CONSTRAINT [R_146] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[cmiAlmacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[cmiMovimientosMaterial] CHECK CONSTRAINT [R_146]
GO
ALTER TABLE [dbo].[cmiMovimientosMaterial]  WITH CHECK ADD  CONSTRAINT [R_147] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiMovimientosMaterial] CHECK CONSTRAINT [R_147]
GO
ALTER TABLE [dbo].[cmiMovimientosMaterial]  WITH CHECK ADD  CONSTRAINT [R_148] FOREIGN KEY([idTipoMovtoMaterial])
REFERENCES [dbo].[cmiTiposMovtoMaterial] ([idTipoMovtoMaterial])
GO
ALTER TABLE [dbo].[cmiMovimientosMaterial] CHECK CONSTRAINT [R_148]
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque]  WITH CHECK ADD  CONSTRAINT [R_149] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque] CHECK CONSTRAINT [R_149]
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque]  WITH CHECK ADD  CONSTRAINT [R_151] FOREIGN KEY([idEtapa])
REFERENCES [dbo].[cmiEtapas] ([idEtapa])
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque] CHECK CONSTRAINT [R_151]
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque]  WITH CHECK ADD  CONSTRAINT [R_OREMB_Proyecto] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[cmiProyectos] ([idProyecto])
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque] CHECK CONSTRAINT [R_OREMB_Proyecto]
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque]  WITH CHECK ADD  CONSTRAINT [R_statusOE_Estatus] FOREIGN KEY([estatusOrdenEmbarque])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiOrdenesEmbarque] CHECK CONSTRAINT [R_statusOE_Estatus]
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
ALTER TABLE [dbo].[cmiProyectos]  WITH CHECK ADD  CONSTRAINT [R_55] FOREIGN KEY([idEstatusRevision])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiProyectos] CHECK CONSTRAINT [R_55]
GO
ALTER TABLE [dbo].[cmiProyectos]  WITH CHECK ADD  CONSTRAINT [R_56] FOREIGN KEY([idCliente])
REFERENCES [dbo].[cmiClientes] ([idCliente])
GO
ALTER TABLE [dbo].[cmiProyectos] CHECK CONSTRAINT [R_56]
GO
ALTER TABLE [dbo].[cmiRegistrarRemision]  WITH CHECK ADD  CONSTRAINT [R_171] FOREIGN KEY([idMarca], [idSerie])
REFERENCES [dbo].[cmiSeries] ([idMarca], [idSerie])
GO
ALTER TABLE [dbo].[cmiRegistrarRemision] CHECK CONSTRAINT [R_171]
GO
ALTER TABLE [dbo].[cmiRegistrarRemision]  WITH CHECK ADD  CONSTRAINT [R_174] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiRegistrarRemision] CHECK CONSTRAINT [R_174]
GO
ALTER TABLE [dbo].[cmiRegistrarRemision]  WITH CHECK ADD  CONSTRAINT [R_175] FOREIGN KEY([idRemision], [idOrdenEmbarque])
REFERENCES [dbo].[cmiRemisionDetalle] ([idRemision], [idOrdenEmbarque])
GO
ALTER TABLE [dbo].[cmiRegistrarRemision] CHECK CONSTRAINT [R_175]
GO
ALTER TABLE [dbo].[cmiRemisionDetalle]  WITH CHECK ADD  CONSTRAINT [R_165] FOREIGN KEY([idRemision])
REFERENCES [dbo].[cmiRemisiones] ([idRemision])
GO
ALTER TABLE [dbo].[cmiRemisionDetalle] CHECK CONSTRAINT [R_165]
GO
ALTER TABLE [dbo].[cmiRemisionDetalle]  WITH CHECK ADD  CONSTRAINT [R_166] FOREIGN KEY([idOrdenEmbarque])
REFERENCES [dbo].[cmiOrdenesEmbarque] ([idOrdenEmbarque])
GO
ALTER TABLE [dbo].[cmiRemisionDetalle] CHECK CONSTRAINT [R_166]
GO
ALTER TABLE [dbo].[cmiRemisionDetalle]  WITH CHECK ADD  CONSTRAINT [R_167] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiRemisionDetalle] CHECK CONSTRAINT [R_167]
GO
ALTER TABLE [dbo].[cmiRemisiones]  WITH CHECK ADD  CONSTRAINT [R_161] FOREIGN KEY([estatusRemision])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiRemisiones] CHECK CONSTRAINT [R_161]
GO
ALTER TABLE [dbo].[cmiRemisiones]  WITH CHECK ADD  CONSTRAINT [R_162] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiRemisiones] CHECK CONSTRAINT [R_162]
GO
ALTER TABLE [dbo].[cmiRemisiones]  WITH CHECK ADD  CONSTRAINT [R_164] FOREIGN KEY([idCliente])
REFERENCES [dbo].[cmiClientes] ([idCliente])
GO
ALTER TABLE [dbo].[cmiRemisiones] CHECK CONSTRAINT [R_164]
GO
ALTER TABLE [dbo].[cmiRemisiones]  WITH CHECK ADD  CONSTRAINT [R_168] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[cmiProyectos] ([idProyecto])
GO
ALTER TABLE [dbo].[cmiRemisiones] CHECK CONSTRAINT [R_168]
GO
ALTER TABLE [dbo].[cmiRemisiones]  WITH CHECK ADD  CONSTRAINT [R_169] FOREIGN KEY([idEtapa])
REFERENCES [dbo].[cmiEtapas] ([idEtapa])
GO
ALTER TABLE [dbo].[cmiRemisiones] CHECK CONSTRAINT [R_169]
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
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [FK__cmiRequis__idAlm__3F115E1A] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[cmiAlmacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [FK__cmiRequis__idAlm__3F115E1A]
GO
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [FK__cmiRequis__idReq__3D2915A8] FOREIGN KEY([idRequerimiento])
REFERENCES [dbo].[cmiRequerimientos] ([idRequerimiento])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [FK__cmiRequis__idReq__3D2915A8]
GO
ALTER TABLE [dbo].[cmiRequisiciones]  WITH CHECK ADD  CONSTRAINT [FK__cmiRequis__usuar__40058253] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiRequisiciones] CHECK CONSTRAINT [FK__cmiRequis__usuar__40058253]
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
ALTER TABLE [dbo].[cmiSeries]  WITH CHECK ADD  CONSTRAINT [R_100] FOREIGN KEY([idEstatusCalidad])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiSeries] CHECK CONSTRAINT [R_100]
GO
ALTER TABLE [dbo].[cmiSeries]  WITH CHECK ADD  CONSTRAINT [R_101] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiSeries] CHECK CONSTRAINT [R_101]
GO
ALTER TABLE [dbo].[cmiSeries]  WITH CHECK ADD  CONSTRAINT [R_110] FOREIGN KEY([idProcesoActual])
REFERENCES [dbo].[cmiProcesos] ([idProceso])
GO
ALTER TABLE [dbo].[cmiSeries] CHECK CONSTRAINT [R_110]
GO
ALTER TABLE [dbo].[cmiSeries]  WITH CHECK ADD  CONSTRAINT [R_113] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiSeries] CHECK CONSTRAINT [R_113]
GO
ALTER TABLE [dbo].[cmiSeries]  WITH CHECK ADD  CONSTRAINT [R_99] FOREIGN KEY([idMarca])
REFERENCES [dbo].[cmiMarcas] ([idMarca])
GO
ALTER TABLE [dbo].[cmiSeries] CHECK CONSTRAINT [R_99]
GO
ALTER TABLE [dbo].[cmiSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_109] FOREIGN KEY([idProcesoActual])
REFERENCES [dbo].[cmiProcesos] ([idProceso])
GO
ALTER TABLE [dbo].[cmiSubMarcas] CHECK CONSTRAINT [R_109]
GO
ALTER TABLE [dbo].[cmiSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_111] FOREIGN KEY([idEstatusCalidad])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiSubMarcas] CHECK CONSTRAINT [R_111]
GO
ALTER TABLE [dbo].[cmiSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_112] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiSubMarcas] CHECK CONSTRAINT [R_112]
GO
ALTER TABLE [dbo].[cmiSubMarcas]  WITH CHECK ADD  CONSTRAINT [R_71] FOREIGN KEY([idEstatusCalidad])
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
