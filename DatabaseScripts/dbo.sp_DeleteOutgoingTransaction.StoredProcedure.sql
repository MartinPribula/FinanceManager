USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteOutgoingTransaction]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteOutgoingTransaction]
(
	@idAccount INT,
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

	SELECT @idWallet = idWallet, @OldBalance = Balance
	FROM [dbo].[Account]
	WHERE id = @idAccount

	UPDATE [dbo].[Account]
	SET Balance = @OldBalance + @Ammount, LastUpdate = GETDATE()
	WHERE id = @idAccount

	UPDATE [dbo].[Wallet]
	SET LastUpdate = GETDATE()
	WHERE id = @idWallet

	DELETE FROM [dbo].[Transaction_Outgoing]
	WHERE id = @idTransaction
END


GO
