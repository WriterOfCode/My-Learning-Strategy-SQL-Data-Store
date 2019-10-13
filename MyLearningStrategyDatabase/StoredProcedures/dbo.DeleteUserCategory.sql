CREATE PROCEDURE [dbo].[DeleteUserCategory]
	@CategoryId INT,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @UserProfileId INT
	DECLARE @ROWSDELETED INT
	SET @UserProfileId=0;
	SET @ROWSDELETED=0;

	SELECT @UserProfileId = UserProfileId
	FROM UserProfiles WHERE Originator = @Originator;

	DECLARE @Error INT;

	BEGIN
		BEGIN TRANSACTION RESPONSE
			DELETE FROM  [dbo].[BodyOfKnowledgeCategories]
			WHERE  UserProfileId=@UserProfileId AND CategoryId= @CategoryId;
			SELECT @Error=@@ERROR;
			SELECT @ROWSDELETED = @@ROWCOUNT;
			IF @Error = 0  
			BEGIN
				DELETE FROM  [dbo].[QuestionCategories]
				WHERE  UserProfileId=@UserProfileId AND CategoryId= @CategoryId;
				SELECT @Error=@@ERROR;
				SELECT @ROWSDELETED = @ROWSDELETED + @@ROWCOUNT;
			END;

			IF @Error = 0  
			BEGIN
				DELETE FROM [dbo].[Categories]
				WHERE  UserProfileId=@UserProfileId AND CategoryId= @CategoryId;
				SELECT @Error=@@ERROR;
				SELECT @ROWSDELETED = @ROWSDELETED + @@ROWCOUNT;
			END;
		IF @Error=0  
			BEGIN
				COMMIT TRANSACTION RESPONSE;
			END
		ELSE
			BEGIN
				ROLLBACK TRANSACTION RESPONSE;
				RAISERROR ('Error in deleting Categories.', 16,  1  );  
			END;
	END;
	

RETURN @ROWSDELETED;