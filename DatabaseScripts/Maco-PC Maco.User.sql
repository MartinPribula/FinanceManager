USE [FinanceManager]
GO
/****** Object:  User [Maco-PC\Maco]    Script Date: 6/9/2016 10:49:41 PM ******/
CREATE USER [Maco-PC\Maco] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Maco-PC\Maco]
GO
