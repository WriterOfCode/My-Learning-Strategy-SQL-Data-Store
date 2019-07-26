CREATE PROCEDURE [dbo].[DeleteUserQuestionCategories]
	@QuestionId INT,
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @UserProfileId INT
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

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