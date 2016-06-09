USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckUser]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CheckUser](
	@UserName VARCHAR(MAX)
)
AS
BEGIN
	SELECT id
	FROM [dbo].[User]
	WHERE UserName = @UserName
END

GO
