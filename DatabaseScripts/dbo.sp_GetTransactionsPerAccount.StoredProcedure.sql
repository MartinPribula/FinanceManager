USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTransactionsPerAccount]    Script Date: 5/17/2016 3:08:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTransactionsPerAccount](
	@idAccount INT
)
AS
BEGIN
	SELECT t.id, c.Name, t.Ammount, CONVERT(varchar(MAX),t.CreationDate, 103) , t.TransactionType
	FROM [dbo].[Transaction] t
	JOIN [dbo].[Category] c ON c.id = t.idCategory
	WHERE idAccount = @idAccount
END
GO
