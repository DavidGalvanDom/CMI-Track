USE [CMITrack]
GO
ALTER TABLE [dbo].[cmiEtapas]  WITH CHECK ADD  CONSTRAINT [RU_14] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[cmiProyectos] ([idProyecto])
GO
ALTER TABLE [dbo].[cmiEtapas] CHECK CONSTRAINT [RU_14]
GO
