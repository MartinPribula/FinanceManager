USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateNewOutgoingTransaction]    Script Date: 5/20/2016 4:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateNewOutgoingTransaction](
	@idAccount INT,
	@idAccountATM INT,
	@Ammount DECIMAL(19,4),
	@idCategory INT
)
AS
BEGIN
	DECLARE @OldBalance DECIMAL(19,4)
	DECLARE @idWallet INT
	DECLARE @AccountType INT

	INSERT INTO [dbo].[Transaction_Outgoing] (Ammount, CreationDate, idAccount, idCategory, LastModified)
	VALUES (@Ammount, GETDATE(), @idAccount, @idCategory, GETDATE())

	SELECT idAccountType
	FROM [dbo].[Account]
	WHERE id = @idAccount

	--vyber z bankomatu cislo kategorie 'vyber z bankomatu - ucet' a typ uctu 'Bankovy ucet/kreditka...'
	IF (@idCategory = 0 AND @AccountType = 0)
	BEGIN
		EXEC [dbo].[sp_CreateNewIncomingTransaction] @idAccountATM, @Ammount, 5 --cislo kategorie 'vyber z bankomatu - hotovost'
	END

	SELECT @OldBalance = Balance, @idWallet = idWallet
	FROM [dbo].[Account]
	WHERE id = @idAccount

	UPDATE [dbo].[Account]
	SET Balance = @OldBalance - @Ammount, LastUpdate = GETDATE()
	WHERE id = @idAccount

	UPDATE [dbo].[Wallet]
	SET LastUpdate = GETDATE()
	WHERE id = @idWallet
END



GO
