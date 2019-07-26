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

	RETURN @bokCount + @adminCount
END
