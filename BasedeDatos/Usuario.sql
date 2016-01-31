USE [CMITrack]
GO

/****** Object:  Table [dbo].[Usuario]    Script Date: 01/30/2016 03:56:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[IdEstatus] [char](3) NOT NULL,
	[Contrasena] [varchar](20) NOT NULL,
	[Correo] [varchar](100) NULL,
	[Nombre] [varchar](50) NULL,
	[ApePaterno] [varchar](50) NULL,
	[ApeMaterno] [varchar](50) NULL,
	[NombreUsuario] [varchar](20) NULL,
	[FechaCreacion] [datetime] NULL,
	[FechaModificacion] [datetime] NULL,
 CONSTRAINT [XPKUsuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

