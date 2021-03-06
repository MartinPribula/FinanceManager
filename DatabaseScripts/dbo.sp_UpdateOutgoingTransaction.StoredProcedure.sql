USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateOutgoingTransaction]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateOutgoingTransaction]
(
	@idAccountNEW INT,
	@idAccountATM INT,
	@Ammount DECIMAL(19,4),
	@idCategory INT,
	@idTransaction INT
)
AS
BEGIN
	DECLARE @OldBalance DECIMAL(19,4)
	DECLARE @idWallet INT
	DECLARE @AccountType INT
	DECLARE @idAccountOld INT
	DECLARE @AmmountOld DECIMAL(19,4)
	DECLARE @NewBalance DECIMAL(19,4)

	SELECT @idAccountOld = idAccount, @AmmountOld = Ammount
	FROM [dbo].[Transaction_Outgoing]
	WHERE id = @idTransaction
	
	SELECT @OldBalance = Balance, @idWallet = idWallet
	FROM [dbo].[Account]
	WHERE id = @idAccountOld

	UPDATE [dbo].[Wallet]
	SET LastUpdate = GETDATE()
	WHERE id = @idWallet

	UPDATE [dbo].[Account]
	SET Balance = @OldBalance + @AmmountOld, LastUpdate = GETDATE()
	WHERE id = @idAccountOld

	UPDATE [dbo].[Transaction_Outgoing]
	SET Ammount = @Ammount, idAccount = @idAccountNew, idCategory = @idCategory, LastModified = GETDATE()
	WHERE id = @idTransaction

	SELECT @NewBalance = Balance, @idWallet = idWallet
	FROM [dbo].[Account]
	WHERE id = @idAccountNew

	UPDATE [dbo].[Account]
	SET Balance = @NewBalance - @Ammount, LastUpdate = GETDATE()
	WHERE id = @idAccountNew

	UPDATE [dbo].[Wallet]
	SET LastUpdate = GETDATE()
	WHERE id = @idWallet
END


GO
