USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTransactionsPerWallet]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTransactionsPerWallet](
	@idWallet INT
)
AS
BEGIN
	SELECT t.id, c.Name, t.Ammount, CONVERT(varchar(MAX),t.CreationDate, 103) , t.TransactionType, a.Name, t.[Description]
	FROM [dbo].[Transaction] t
	JOIN [dbo].[Category] c ON c.id = t.idCategory
	JOIN [dbo].[Account] a ON t.idAccount = a.id
	WHERE idAccount IN
	(
		SELECT id
		FROM [dbo].[Account]
		WHERE idWallet = @idWallet
	)
	ORDER BY t.CreationDate DESC
END
GO
