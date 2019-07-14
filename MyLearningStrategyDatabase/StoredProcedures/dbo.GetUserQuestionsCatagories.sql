CREATE PROCEDURE [dbo].[GetUserQuestionsCatagories]
	@QuestionId INT,
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	IF (@CategoryId IS NOT NULL)
		BEGIN
			SELECT QuestionId, CategoryId, UserProfileId, LastModifiedOffset, CloudRowId
			FROM [dbo].[QuestionCategories]
			WHERE  QuestionId=@QuestionId AND CategoryId=@CategoryId 
		END
		
	ELSE
		BEGIN
			SELECT  QuestionId, CategoryId, UserProfileId, LastModifiedOffset, CloudRowId
			FROM [dbo].[QuestionCategories]
			WHERE QuestionId=@QuestionId
		END

	
RETURN 0
