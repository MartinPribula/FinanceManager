USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateNewIncomingTransaction]    Script Date: 5/20/2016 4:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateNewIncomingTransaction](
	@idAccount INT,
	@Ammount DECIMAL(19,4),
	@idCategory INT
)
AS
BEGIN
	DECLARE @OldBalance DECIMAL(19,4)
	DECLARE @idWallet INT

	INSERT INTO [dbo].[Transaction_Incoming] (Ammount, CreationDate, idAccount, idCategory, LastModified)
	VALUES (@Ammount, GETDATE(), @idAccount, @idCategory, GETDATE())

	SELECT @OldBalance = Balance, @idWallet = idWallet
	FROM [dbo].[Account]
	WHERE id = @idAccount

	UPDATE [dbo].[Account]
	SET Balance = @OldBalance + @Ammount, LastUpdate = GETDATE()
	WHERE id = @idAccount

	UPDATE [dbo].[Wallet]
	SET LastUpdate = GETDATE()
	WHERE id = @idWallet
END



GO
