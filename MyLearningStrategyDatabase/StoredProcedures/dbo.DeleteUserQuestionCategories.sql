CREATE PROCEDURE [dbo].[DeleteUserQuestionCategories]
	@QuestionId INT,
	@CategoryId INT NULL,
	@UserProfileId INT,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	    
	IF (@CategoryId IS NULL)
		BEGIN
			DELETE FROM [dbo].[QuestionCategories]
			WHERE QuestionId = @QuestionId 
			AND UserProfileId = @UserProfileId
		END
	ELSE
		BEGIN
			DELETE FROM [dbo].[QuestionCategories]
			WHERE QuestionId = @QuestionId 
			AND UserProfileId = @UserProfileId
			AND CategoryId = @CategoryId
		END
RETURN 0