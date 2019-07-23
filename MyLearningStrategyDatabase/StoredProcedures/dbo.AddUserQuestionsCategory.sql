CREATE PROCEDURE [dbo].[AddUserQuestionsCategory]
    @QuestionId INT, 
    @CategoryId INT,
	@UserProfileId INT

AS
	BEGIN
		INSERT INTO [dbo].[QuestionCategories]
		(QuestionId,CategoryId,UserProfileId )
		VALUES (@QuestionId,@CategoryId,@UserProfileId);
	END
RETURN