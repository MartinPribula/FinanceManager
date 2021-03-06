USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateWallet]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateWallet](
	@idUser INT,
	@WalletName VARCHAR(MAX),
	@TransactionCategoryList TransactionCategoryList READONLY
)
AS
BEGIN
	INSERT INTO [dbo].[Wallet] (LastUpdate, Name)
	VALUES (GETUTCDATE(), @WalletName)

	DECLARE @idWallet INT = SCOPE_IDENTITY()
	DECLARE @idAccountType INT

	INSERT INTO [dbo].[Users_Wallets] (idWallet, idUser, ReadPermission, WritePermission, IsOwner)
	VALUES (@idWallet, @idUser, 1, 1, 1)

	DECLARE @idUserWallet INT = SCOPE_IDENTITY()

	INSERT INTO Categories_In_Wallet (idWallet, idCategory, Visible)
	SELECT @idWallet, TransactionCategoryId, 1 FROM @TransactionCategoryList

	SELECT id
	FROM [dbo].[Wallet]
	WHERE id = @idWallet
END



GO
