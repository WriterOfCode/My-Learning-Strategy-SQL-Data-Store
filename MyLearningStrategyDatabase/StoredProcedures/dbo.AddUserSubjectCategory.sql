CREATE PROCEDURE [dbo].[AddUserSubjectCategory]
    @BodyOfKnowledgeId INT, 
    @CategoryId INT,
	@Originator uniqueidentifier
AS
	BEGIN
		DECLARE @UserProfileId INT
		SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

		INSERT INTO [dbo].[BodyOfKnowledgeCategories]
		(BodyOfKnowledgeId,CategoryId,UserProfileId )
		VALUES (@BodyOfKnowledgeId,@CategoryId,@UserProfileId);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END
RETURN