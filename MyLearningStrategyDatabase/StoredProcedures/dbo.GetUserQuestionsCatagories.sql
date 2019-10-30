CREATE PROCEDURE [dbo].[GetUserQuestionsCatagories]
	@QuestionId INT NULL,
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

	IF  @CategoryId IS NULL 
	BEGIN
		SELECT  qc.QuestionId, qc.CategoryId, qc.UserProfileId, qc.LastModifiedOffset, qc.CloudRowId,
		c.ImageDevice,c.ImageCloud,c.ImageHash
		FROM [dbo].[QuestionCategories] qc
		JOIN [dbo].[Categories] c 
		on c.CategoryId=qc.CategoryId and c.UserProfileId=qc.UserProfileId
		JOIN [dbo].[UserProfiles] u
		on u.UserProfileId=c.UserProfileId
		WHERE u.Originator=@Originator;
	END
	ELSE
	BEGIN
		SELECT  qc.QuestionId, qc.CategoryId, qc.UserProfileId, qc.LastModifiedOffset, qc.CloudRowId,
		c.ImageDevice,c.ImageCloud,c.ImageHash
		FROM [dbo].[QuestionCategories] qc
		JOIN [dbo].[Categories] c 
		on c.CategoryId=qc.CategoryId and c.UserProfileId=qc.UserProfileId
		JOIN [dbo].[UserProfiles] u
		on u.UserProfileId=c.UserProfileId
		WHERE qc.QuestionId=@QuestionId
		and  c.CategoryId=@CategoryId
		and  u.Originator=@Originator;
	END
RETURN 0