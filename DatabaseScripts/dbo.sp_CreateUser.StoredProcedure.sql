USE [FinanceManager]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateUser]    Script Date: 5/20/2016 4:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateUser](
	@FirstName NVARCHAR(MAX),
	@LastName NVARCHAR(MAX),
	@Password NVARCHAR(MAX),
	@UserName NVARCHAR(MAX),
	@Email NVARCHAR(MAX)
)
AS
BEGIN	
	INSERT INTO [dbo].[User]
           ([UserName]
           ,[FirstName]
           ,[LastName]
           ,[Password]
           ,[Email]
		   ,[DateCreated])
	VALUES (@UserName, @FirstName, @LastName, @Password, @Email, GETUTCDATE())

	DECLARE @idRet INT = SCOPE_IDENTITY()
END




GO
