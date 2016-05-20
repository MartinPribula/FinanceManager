USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckWallet]    Script Date: 5/20/2016 4:13:37 PM ******/
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
