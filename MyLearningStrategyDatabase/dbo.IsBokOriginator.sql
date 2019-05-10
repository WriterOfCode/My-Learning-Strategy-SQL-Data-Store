CREATE FUNCTION [dbo].[IsBokOriginator]
(
	@Originator uniqueidentifier,
	@BodyOfKnowledgeId int
)
RETURNS INT
AS
BEGIN
	DECLARE @UserProfileId INT

	SELECT @UserProfileId = MAX(UP.UserProfileId)
	FROM BodyOfKnowledge BOK
	INNER JOIN UserProfiles UP 
	ON UP.UserProfileId = BOK.UserProfileId
	WHERE UP.Originator = @Originator
	AND BOK.BodyOfKnowledgeId = @BodyOfKnowledgeId;

	RETURN @UserProfileId
END
