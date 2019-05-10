CREATE FUNCTION [dbo].[IsQuestionOriginator]
(
	@Originator uniqueidentifier,
	@QuestionId int
)
RETURNS INT
AS
BEGIN
	DECLARE @bokCount INT

	SELECT @bokCount = COUNT(*) 
	FROM UserProfiles UP
	INNER JOIN BodyOfKnowledge BOK
	ON UP.UserProfileId = BOK.UserProfileId
	INNER JOIN Questions Q
	ON Q.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
	WHERE  UP.Originator = @Originator
	AND Q.QuestionId = @QuestionId

	RETURN @bokCount
END