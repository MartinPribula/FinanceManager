USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTransactionCategories]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTransactionCategories]
AS
BEGIN
	SELECT id, Name
	FROM [dbo].[Category]
	WHERE isDefault = 1
END
GO
