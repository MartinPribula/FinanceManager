USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTransactionsInInterval]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTransactionsInInterval](
	@idWallet INT,
	@from DATETIME,
	@to DATETIME
)
AS
BEGIN
	SELECT id, Ammount, TransactionType
	FROM [dbo].[Transaction]
	WHERE CreationDate >= @from AND CreationDate <= @to AND idAccount IN
	(
		SELECT id
		FROM [dbo].[Account]
		WHERE idWallet = @idWallet
	)
END

GO
