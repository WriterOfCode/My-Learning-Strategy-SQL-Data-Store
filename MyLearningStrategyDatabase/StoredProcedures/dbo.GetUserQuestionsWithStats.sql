CREATE PROCEDURE [dbo].[GetUserQuestionsWithStats]
    @BodyOfKnowledgeId INT NULL,
	@Originator UNIQUEIDENTIFIER NULL
AS

	BEGIN
		SELECT QuestionId,
			Q.BodyOfKnowledgeId,
			OrderBy,
			Question,
			Image_1_Device, 
			Image_1_Cloud, 
			Image_1_Hash,
			Image_2_Device, 
			Image_2_Cloud, 
			Image_2_Hash,
			Image_3_Device, 
			Image_3_Cloud, 
			Image_3_Hash,
			Hyperlink_1,
			Hyperlink_2,
			Hyperlink_3,
			Q.LastModifiedOffset,
			Q.CloudRowId,
			Mnemonic,
			(SELECT COUNT(*) from Responses RC where RC.QuestionId = Q.QuestionId) AS ResponseCount,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP
				JOIN LearningHistory LH ON LH.StrategyHistoryId = LP.StrategyHistoryId 
				WHERE LH.BodyOfKnowledgeId = Q.BodyOfKnowledgeId and LP.QuestionId=Q.QuestionId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredIncorrectlyCount),0) FROM LearningHistoryProgress LP
				JOIN LearningHistory LH ON LH.StrategyHistoryId = LP.StrategyHistoryId 
				WHERE LH.BodyOfKnowledgeId = Q.BodyOfKnowledgeId and LP.QuestionId=Q.QuestionId) AS AnsweredIncorrectly
		FROM [Questions] Q
		  Join BodyOfKnowledge k
		  on Q.BodyOfKnowledgeId = k.BodyOfKnowledgeId
		  WHERE k.BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END

RETURN 0
