USE [FinanceManager]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idWallet] [int] NOT NULL,
	[idAccountType] [int] NOT NULL,
	[Balance] [decimal](19, 4) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Type] FOREIGN KEY([idAccountType])
REFERENCES [dbo].[AccountType] ([id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Type]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Wallet] FOREIGN KEY([idWallet])
REFERENCES [dbo].[Wallet] ([id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Wallet]
GO
