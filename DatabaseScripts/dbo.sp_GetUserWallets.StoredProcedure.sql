USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserWallets]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserWallets](
	@idUser VARCHAR(MAX)
)
AS
BEGIN
	SELECT id, Balance, LastUpdate, idUser, Name
	FROM [dbo].[V_Wallet_Balance]
	WHERE idUser = @idUser
END
GO
