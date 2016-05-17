USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserWallets]    Script Date: 5/17/2016 3:08:43 PM ******/
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
