CREATE PROCEDURE [dbo].[AddUserQuestionsCategory]
    @QuestionId INT, 
    @CategoryId INT,
	@Originator uniqueidentifier
AS
	BEGIN
		DECLARE @UserProfileId INT
		SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)
		IF (@UserProfileId is null)
		BEGIN
			RAISERROR (13538,14,-1, 'User not found!');   
		END
		INSERT INTO [dbo].[QuestionCategories]
		(QuestionId,CategoryId,UserProfileId )
		VALUES (@QuestionId,@CategoryId,@UserProfileId);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END
RETURN