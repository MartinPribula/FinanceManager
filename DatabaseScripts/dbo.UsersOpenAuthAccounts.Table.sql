USE [FinanceManager]
GO
/****** Object:  Table [dbo].[UsersOpenAuthAccounts]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersOpenAuthAccounts](
	[ApplicationName] [nvarchar](128) NOT NULL,
	[ProviderName] [nvarchar](128) NOT NULL,
	[ProviderUserId] [nvarchar](128) NOT NULL,
	[ProviderUserName] [nvarchar](max) NOT NULL,
	[MembershipUserName] [nvarchar](128) NOT NULL,
	[LastUsedUtc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationName] ASC,
	[ProviderName] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[UsersOpenAuthAccounts]  WITH CHECK ADD  CONSTRAINT [OpenAuthAccount_UserData] FOREIGN KEY([ApplicationName], [MembershipUserName])
REFERENCES [dbo].[UsersOpenAuthData] ([ApplicationName], [MembershipUserName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsersOpenAuthAccounts] CHECK CONSTRAINT [OpenAuthAccount_UserData]
GO
