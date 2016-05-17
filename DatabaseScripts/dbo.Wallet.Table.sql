USE [FinanceManager]
GO
/****** Object:  Table [dbo].[Wallet]    Script Date: 5/17/2016 3:08:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wallet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Wallet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
