USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_TransPerMonthCategory]    Script Date: 5/20/2016 4:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TransPerMonthCategory](
	@idWallet INT,
	@fromDate DATE,
	@idCategories AS [dbo].[TransactionCategoryList] READONLY
)
AS
BEGIN
	SELECT t.id, c.Name, Ammount, CONVERT(varchar(MAX), CreationDate, 103),TransactionType
	FROM [dbo].[Transaction] t
	JOIN [dbo].[Category] c ON t.idCategory = c.id
	WHERE idAccount IN
	(
		SELECT id
		FROM [dbo].[Account]
		WHERE idWallet = @idWallet
	)
	AND CreationDate > @fromDate AND idCategory IN (SELECT TransactionCategoryId FROM @idCategories)
END
GO
