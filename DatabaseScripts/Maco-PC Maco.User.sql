USE [FinanceManager]
GO
/****** Object:  User [Maco-PC\Maco]    Script Date: 5/17/2016 3:08:42 PM ******/
CREATE USER [Maco-PC\Maco] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Maco-PC\Maco]
GO
