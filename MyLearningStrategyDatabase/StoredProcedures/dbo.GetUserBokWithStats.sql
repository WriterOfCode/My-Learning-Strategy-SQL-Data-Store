﻿CREATE PROCEDURE [dbo].[GetBokWithStats]
		@BodyOfKnowledgeId INT NULL,
		@Originator uniqueidentifier
AS

IF @BodyOfKnowledgeId IS NULL
BEGIN
	SELECT BOK.BodyOfKnowledgeId,BOK.UserProfileId,BOK.Name,BOK.Description, BOK.Keywords,
	BOK.ImageDevice, BOK.ImageCloud,BOK.ImageHash, 
	BOK.IsShared, BOK.HasBeenShared, BOK.LastModifiedOffset, BOK.CloudRowId,
	(SELECT COUNT(*) from Questions QC where QC.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS QuestionsCount,
	(SELECT COUNT(*) from LearningHistory AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId group by AD.StrategyId) AS LearningStrategiesCount,
	(SELECT SUM(NumberOfTimesTried) from LearningHistory AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS LearningHistoryCount,
	ISNULL((SELECT SUM( ISNULL(LP.AnsweredCorrectlyCount, 0 )) FROM LearningHistoryProgress LP
	JOIN LearningHistory LH ON LH.StrategyHistoryId = LP.StrategyHistoryId 
	WHERE LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId),0) AS AnsweredCorrectlyCount
	FROM BodyOfKnowledge BOK
	JOIN UserProfiles U ON U.UserProfileId = BOK.UserProfileId
	WHERE U.Originator = @Originator
END 
ELSE
	BEGIN 
		IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
		BEGIN
			RAISERROR (13538,14,-1, 'User is not the owner!');   
		END

		SELECT BOK.BodyOfKnowledgeId,BOK.UserProfileId,BOK.Name,BOK.Description, BOK.Keywords,
		BOK.IsShared, BOK.HasBeenShared, BOK.LastModifiedOffset, BOK.CloudRowId,
		BOK.ImageDevice, BOK.ImageCloud,BOK.ImageHash, 
		(SELECT COUNT(*) from Questions QC where QC.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS QuestionsCount,
		(SELECT COUNT(AD.StrategyId) from LearningHistory AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId group by AD.StrategyId) AS LearningStrategiesCount,
		(SELECT SUM(NumberOfTimesTried) from LearningHistory AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS LearningHistoryCount,
		ISNULL((SELECT SUM( ISNULL(LP.AnsweredCorrectlyCount, 0 )) FROM LearningHistoryProgress LP
		JOIN LearningHistory LH ON LH.StrategyHistoryId = LP.StrategyHistoryId 
		WHERE LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId),0) AS AnsweredCorrectlyCount
		FROM BodyOfKnowledge BOK JOIN UserProfiles U ON U.UserProfileId = BOK.UserProfileId
		WHERE U.Originator = @Originator
		AND BOK.BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END 
RETURN 0
