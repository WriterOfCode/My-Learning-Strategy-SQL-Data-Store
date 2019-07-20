CREATE PROCEDURE [dbo].[GetUserQuestionsCatagories]
	@QuestionId INT,
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	IF  @CategoryId IS NULL
	BEGIN
		SELECT  qc.QuestionId, qc.CategoryId, qc.UserProfileId, qc.LastModifiedOffset, qc.CloudRowId,
		c.ImageDevice,c.ImageCloud,c.ImageHash
		FROM [dbo].[QuestionCategories] qc
		JOIN [dbo].[Categories] c 
		on c.CategoryId=qc.CategoryId and c.UserProfileId=qc.UserProfileId
		WHERE  qc.QuestionId=@QuestionId
	END
	ELSE
	BEGIN
		SELECT  qc.QuestionId, qc.CategoryId, qc.UserProfileId, qc.LastModifiedOffset, qc.CloudRowId,
		c.ImageDevice,c.ImageCloud,c.ImageHash
		FROM [dbo].[QuestionCategories] qc
		JOIN [dbo].[Categories] c 
		on c.CategoryId=qc.CategoryId and c.UserProfileId=qc.UserProfileId
		WHERE qc.QuestionId=@QuestionId
	END
RETURN 0