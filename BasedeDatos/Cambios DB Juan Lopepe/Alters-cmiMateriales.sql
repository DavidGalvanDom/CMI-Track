USE [CMITrack]
GO
ALTER TABLE [dbo].[cmiMateriales]  WITH CHECK ADD  CONSTRAINT [RU_15] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[cmiEstatus] ([idEstatus])
GO
ALTER TABLE [dbo].[cmiMateriales] CHECK CONSTRAINT [RU_15]
GO
