USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTransactionCategoriesForWallet]    Script Date: 5/17/2016 3:08:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTransactionCategoriesForWallet](
	@idWallet INT
)
AS
BEGIN
	SELECT c.id, c.Name
	FROM [dbo].[Categories_In_Wallet] cw
	JOIN [dbo].[Category] c ON cw.idCategory = c.id
	WHERE idWallet = @idWallet
END

GO
