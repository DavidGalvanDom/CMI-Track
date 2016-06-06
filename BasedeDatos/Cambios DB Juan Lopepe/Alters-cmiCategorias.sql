USE [CMITrack]
GO
ALTER TABLE [dbo].[cmiCategorias] DROP CONSTRAINT [R_14]
GO
ALTER TABLE [dbo].[cmiCategorias] DROP COLUMN [idUsuario]
GO
ALTER TABLE [dbo].[cmiCategorias]  WITH CHECK ADD  CONSTRAINT [R_14] FOREIGN KEY([usuarioCreacion])
REFERENCES [dbo].[cmiUsuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[cmiCategorias] CHECK CONSTRAINT [R_14]
GO

