USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_TransPerMonthCategory]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TransPerMonthCategory](
	@idWallet INT,
	@fromDate DATE,
	@toDate DATE,
	@idCategories AS [dbo].[TransactionCategoryList] READONLY,
	@idAccounts AS [dbo].[AccountIdList] READONLY
)
AS
BEGIN
	SELECT t.id, c.Name, Ammount, CONVERT(varchar(MAX), CreationDate, 103),TransactionType, a.Name
	FROM [dbo].[Transaction] t
	JOIN [dbo].[Category] c ON t.idCategory = c.id
	JOIN [dbo].[Account] a ON t.idAccount = a.id
	WHERE idAccount IN
	(
		SELECT id
		FROM [dbo].[Account]
		WHERE idWallet = @idWallet
	)
	AND CreationDate >= @fromDate AND CreationDate <= @toDate AND idAccount IN (SELECT AccountId FROM @idAccounts) AND idCategory IN (SELECT TransactionCategoryId FROM @idCategories)
END
GO
