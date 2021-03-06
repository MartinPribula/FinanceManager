USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateNewTransaction]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateNewTransaction](
	@idAccount INT,
	@Ammount DECIMAL(19,4),
	@idCategory INT,
	@CreationDate DATETIME,
	@Description VARCHAR(MAX),
	@TransactionType INT,
	@idWallet INT
)
AS
BEGIN
	DECLARE @OldBalance DECIMAL(19,4)
	DECLARE @idWalletDb INT

	INSERT INTO [dbo].[Transaction] (Ammount, CreationDate, idAccount, idCategory, LastModified, [Description], TransactionType)
	VALUES (@Ammount, @CreationDate, @idAccount, @idCategory, GETUTCDATE(), @Description, @TransactionType)

	DECLARE @idTransaction INT = SCOPE_IDENTITY()

	SELECT @OldBalance = Balance, @idWalletDb = idWallet
	FROM [dbo].[Account]
	WHERE id = @idAccount	

	UPDATE [dbo].[Account]
	SET Balance = @OldBalance + @Ammount, LastUpdate = GETDATE()
	WHERE id = @idAccount

	UPDATE [dbo].[Wallet]
	SET LastUpdate = GETDATE()
	WHERE id = @idWalletDb

	SELECT id
	FROM [dbo].[Transaction]
	WHERE id = @idTransaction
END



GO
