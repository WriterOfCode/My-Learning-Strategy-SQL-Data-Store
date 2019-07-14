CREATE PROCEDURE [dbo].[AddUserQuestionsCategory]
    @QuestionId INT NULL, 
    @CategoryId INT NULL,
	@UserProfileId INT NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@Originator UNIQUEIDENTIFIER NULL
AS
	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		INSERT INTO [dbo].[QuestionCategories]
		(QuestionId,CategoryId,UserProfileId )
		VALUES (@QuestionId,@CategoryId,@UserProfileId);
	END
RETURN