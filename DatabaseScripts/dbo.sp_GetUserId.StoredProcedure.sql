USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserId]    Script Date: 5/20/2016 4:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserId](
	@userName VARCHAR(MAX)
)
AS
BEGIN
	SELECT id
	FROM [dbo].[User]
	WHERE UserName = @userName
END


GO
