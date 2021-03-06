USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCashAccountsPerWallet]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCashAccountsPerWallet](
	@idWallet INT
)
AS
BEGIN
	SELECT a.id, a.Name, a.Balance, a.LastUpdate, t.Name
	FROM [dbo].[Account] a
	JOIN [dbo].AccountType t ON t.id = a.idAccountType
	WHERE idWallet = @idWallet AND t.id = 2
END
GO
