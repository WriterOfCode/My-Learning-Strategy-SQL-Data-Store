CREATE PROCEDURE [dbo].[GetUserQuestionsCatagories]
	@QuestionId INT,
	@UserProfileId INT,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		SELECT  QuestionId, CategoryId, UserProfileId, LastModifiedOffset, CloudRowId
		FROM [dbo].[QuestionCategories]
		WHERE QuestionId=@QuestionId and UserProfileId=@UserProfileId
	END
RETURN 0