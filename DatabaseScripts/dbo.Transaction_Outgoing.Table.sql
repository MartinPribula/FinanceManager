USE [FinanceManager]
GO
/****** Object:  Table [dbo].[Transaction_Outgoing]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction_Outgoing](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Ammount] [decimal](19, 4) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[idAccount] [int] NOT NULL,
	[idCategory] [int] NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Transaction_Outgoing]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[Account] ([id])
GO
ALTER TABLE [dbo].[Transaction_Outgoing] CHECK CONSTRAINT [FK_Transaction_Account]
GO
ALTER TABLE [dbo].[Transaction_Outgoing]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Category] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Transaction_Outgoing] CHECK CONSTRAINT [FK_Transaction_Category]
GO
