CREATE FUNCTION [dbo].[IsBokUsers]
(
	@UserProfileId int,
	@BodyOfKnowledgeId int
)
RETURNS INT
AS
BEGIN
	DECLARE @bokCount INT
	DECLARE @adminCount INT

	--INSERT INTO @bokCount
	SELECT @bokCount = COUNT(*)
	FROM [BodyOfKnowledge]
	WHERE UserProfileId = @UserProfileId
	AND BodyOfKnowledgeId = @BodyOfKnowledgeId;

	--INSERT INTO @adminCount
	SELECT @adminCount = COUNT(*)
	FROM [dbo].[UserPermissions]
	WHERE UserProfileId = @UserProfileId
	AND ClaimType LIKE 'Admin%'

	RETURN @bokCount + @adminCount
END
