USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateAccount]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateAccount](
	@idWallet INT,
	@AccountName VARCHAR(MAX),
	@AccountType VARCHAR(MAX),
	@AccountBallance Decimal(19,4)
)
AS
BEGIN
	DECLARE @idAccountType INT
	SELECT @idAccountType = [id]
	FROM [dbo].[AccountType]
	WHERE [Name] = @AccountType

	INSERT INTO [dbo].[Account] (idWallet, idAccountType, Balance, LastUpdate, Name)
	VALUES (@idWallet, @idAccountType, @AccountBallance, GETUTCDATE(), @AccountName)

	DECLARE @idAccount INT = SCOPE_IDENTITY()

	SELECT id
	FROM [dbo].[Account]
	WHERE id = @idAccount
END


GO
