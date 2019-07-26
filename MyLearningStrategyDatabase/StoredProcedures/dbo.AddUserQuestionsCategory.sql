CREATE PROCEDURE [dbo].[AddUserQuestionsCategory]
    @QuestionId INT, 
    @CategoryId INT,
	@Originator uniqueidentifier
AS
	BEGIN
		DECLARE @UserProfileId INT
		SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

		INSERT INTO [dbo].[QuestionCategories]
		(QuestionId,CategoryId,UserProfileId )
		VALUES (@QuestionId,@CategoryId,@UserProfileId);
	END
RETURN