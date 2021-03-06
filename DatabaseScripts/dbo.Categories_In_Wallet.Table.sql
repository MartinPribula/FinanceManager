USE [FinanceManager]
GO
/****** Object:  Table [dbo].[Categories_In_Wallet]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories_In_Wallet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idWallet] [int] NOT NULL,
	[idCategory] [int] NOT NULL,
	[Visible] [int] NOT NULL,
 CONSTRAINT [PK_Categories_In_Wallet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Categories_In_Wallet]  WITH CHECK ADD  CONSTRAINT [FK_Categories_In_Wallet_Category] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Categories_In_Wallet] CHECK CONSTRAINT [FK_Categories_In_Wallet_Category]
GO
ALTER TABLE [dbo].[Categories_In_Wallet]  WITH CHECK ADD  CONSTRAINT [FK_Categories_In_Wallet_Wallet] FOREIGN KEY([idWallet])
REFERENCES [dbo].[Wallet] ([id])
GO
ALTER TABLE [dbo].[Categories_In_Wallet] CHECK CONSTRAINT [FK_Categories_In_Wallet_Wallet]
GO
