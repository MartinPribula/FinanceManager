USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckCategory]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CheckCategory](
	@CategoryName VARCHAR(MAX)
)
AS
BEGIN
	SELECT id, isDefault
	FROM [dbo].[Category]
	WHERE Name = @CategoryName
END


GO
