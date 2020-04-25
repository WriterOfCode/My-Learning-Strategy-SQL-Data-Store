CREATE PROCEDURE [dbo].[DeleteUserSubjectCategory]     
	@BodyOfKnowledgeId INT, 
    @CategoryId INT NULL,
	@Originator uniqueidentifier
AS
	DECLARE @UserProfileId INT
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

	IF (@CategoryId IS NULL)
		BEGIN
			DELETE FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId 
			AND UserProfileId=@UserProfileId
		END
	ELSE
		BEGIN
			DELETE FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId 
			AND CategoryId=@CategoryId
			AND UserProfileId=@UserProfileId
		END

RETURN 0