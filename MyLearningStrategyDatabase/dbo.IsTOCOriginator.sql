CREATE FUNCTION [dbo].[IsTOCOriginator]
(
	@Originator uniqueidentifier,
	@TableOfContentId int
)
RETURNS INT
AS
BEGIN
	DECLARE @bokCount INT

	SELECT @bokCount = COUNT(*) 
	FROM UserProfiles UP
	INNER JOIN BodyOfKnowledge BOK
	ON UP.UserProfileId = BOK.UserProfileId
	INNER JOIN LearningPlanTableOfContents TOC
	ON TOC.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
	WHERE  UP.Originator = @Originator
	AND TOC.TableOfContentId = @TableOfContentId

	RETURN @bokCount
END