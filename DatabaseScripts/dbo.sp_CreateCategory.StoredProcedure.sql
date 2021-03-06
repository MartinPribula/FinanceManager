USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateCategory]    Script Date: 6/9/2016 10:49:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateCategory](
	@CategoryName VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO [dbo].[Category] (Name, isDefault)
	VALUES (@CategoryName, 0)

	DECLARE @idCategory INT = SCOPE_IDENTITY()

	SELECT id
	FROM [dbo].[Category]
	WHERE id = @idCategory
END

GO
