USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckWallet]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CheckWallet](
	@idWallet INT
)
AS
BEGIN
	SELECT [idUser]
	FROM [dbo].[Users_Wallets]
	WHERE idWallet = @idWallet
END
GO
