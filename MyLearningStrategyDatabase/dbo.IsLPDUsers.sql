CREATE FUNCTION [dbo].[IsLPDUsers]
(
	@Originator uniqueidentifier,
	@LearningPlanDefinitionId int
)
RETURNS INT
AS
BEGIN

	DECLARE @UserProfileId INT

	SELECT @UserProfileId = COUNT(UP.UserProfileId)
	FROM LearningPlanDefinitions LPD
	INNER JOIN BodyOfKnowledge BOK
	ON LPD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
	INNER JOIN UserProfiles UP 
	ON UP.UserProfileId = BOK.UserProfileId
	WHERE UP.Originator = @Originator
	AND LPD.LearningPlanDefinitionId = @LearningPlanDefinitionId;

	RETURN @UserProfileId
END