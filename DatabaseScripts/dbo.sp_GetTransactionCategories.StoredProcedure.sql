USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTransactionCategories]    Script Date: 5/20/2016 4:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTransactionCategories]
AS
BEGIN
	SELECT id, Name
	FROM [dbo].[Category]
END
GO
