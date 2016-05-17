USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAccountsPerWallet]    Script Date: 5/17/2016 3:08:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAccountsPerWallet](
	@idWallet INT
)
AS
BEGIN
	SELECT a.id, a.Name, a.Balance, a.LastUpdate, t.Name
	FROM [dbo].[Account] a
	JOIN [dbo].AccountType t ON t.id = a.idAccountType
	WHERE idWallet = @idWallet
END
GO
