USE [FinanceManager]
GO
/****** Object:  Table [dbo].[Users_Wallets]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_Wallets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idWallet] [int] NOT NULL,
	[idUser] [int] NOT NULL,
	[ReadPermission] [int] NOT NULL,
	[WritePermission] [int] NOT NULL,
	[IsOwner] [int] NULL,
 CONSTRAINT [PK_Users-Wallets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Users_Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Users-Wallets_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Users_Wallets] CHECK CONSTRAINT [FK_Users-Wallets_User]
GO
ALTER TABLE [dbo].[Users_Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Users-Wallets_Wallet] FOREIGN KEY([idWallet])
REFERENCES [dbo].[Wallet] ([id])
GO
ALTER TABLE [dbo].[Users_Wallets] CHECK CONSTRAINT [FK_Users-Wallets_Wallet]
GO
