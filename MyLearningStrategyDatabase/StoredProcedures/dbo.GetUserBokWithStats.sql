CREATE PROCEDURE [dbo].[GetBokWithStats]
		@BodyOfKnowledgeId INT NULL,
		@Originator uniqueidentifier
AS

IF @BodyOfKnowledgeId IS NULL
BEGIN
	SELECT BOK.BodyOfKnowledgeId,BOK.Name,BOK.Acronym, BOK.Keywords,
	BOK.IsShared, BOK.HasBeenShared, BOK.LastModifiedOffset, BOK.CloudRowId,
	(SELECT COUNT(*) from Questions QC where QC.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS QuestionsCount,
	(SELECT COUNT(*) from LearningStrategies AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS LearningStrategiesCount
	FROM BodyOfKnowledge BOK
	JOIN UserProfiles U ON U.UserProfileId = BOK.UserProfileId
	WHERE U.Originator = @Originator;
END 
ELSE
	BEGIN 
		IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
		BEGIN
			RAISERROR (13538,14,-1, 'User is not the owner!');   
		END

		SELECT BOK.BodyOfKnowledgeId,BOK.Name,BOK.Acronym, BOK.Keywords,
		BOK.IsShared, BOK.HasBeenShared, BOK.LastModifiedOffset, BOK.CloudRowId,
		(SELECT COUNT(*) from Questions QC where QC.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS QuestionsCount,
		(SELECT COUNT(*) from LearningStrategies AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS LearningStrategiesCount
		FROM BodyOfKnowledge BOK
		JOIN UserProfiles U ON U.UserProfileId = BOK.UserProfileId
		WHERE U.Originator = @Originator
		AND BOK.BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END 
RETURN 0
