USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 5/17/2016 3:08:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_LoginUser](
	@idUser int = null OUTPUT,
	@userName VARCHAR(MAX) OUTPUT,
	@password VARCHAR(MAX)
)
AS
BEGIN
 
	SELECT @idUser = id, @userName = UserName
	FROM [dbo].[User]
	WHERE UserName = @userName AND [Password] = @password
	
	RETURN
END



GO
