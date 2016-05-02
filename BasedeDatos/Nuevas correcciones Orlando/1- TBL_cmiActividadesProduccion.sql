
/* CAMBIOS A LA ESTRUCTURA DE BBDD */
-- Elimino tablas innecesarias
DROP TABLE cmiHistoricoAvances;
DROP TABLE cmiRegistrosCalidad;
GO

-- Creo tabla de Actividades
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