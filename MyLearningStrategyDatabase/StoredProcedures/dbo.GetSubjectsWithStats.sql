CREATE PROCEDURE [dbo].[GetSubjectsWithStats]
		@BodyOfKnowledgeId INT NULL,
		@Originator uniqueidentifier
AS

IF (@Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetSubjectsWithStats.@Originator');   
END

IF @BodyOfKnowledgeId IS NULL
BEGIN
	SELECT BOK.BodyOfKnowledgeId,BOK.Name,BOK.Acronym, BOK.Keywords,
	BOK.IsShared, BOK.HasBeenShared, BOK.LastModifiedOffset, BOK.CloudRowId,
	(SELECT COUNT(*) from Questions QC where QC.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS QuestionsCount,
	(SELECT COUNT(*) from AssessmentDefinitions AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS AssessmentsCount
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
		(SELECT COUNT(*) from AssessmentDefinitions AD where AD.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId) AS AssessmentsCount
		FROM BodyOfKnowledge BOK
		JOIN UserProfiles U ON U.UserProfileId = BOK.UserProfileId
		WHERE U.Originator = @Originator
		AND BOK.BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END 
RETURN 0
