CREATE PROCEDURE [dbo].[GetUserLearningHistoryWithStats]
	@StrategyHistoryId INT NULL , 
	@StrategyId INT NULL ,
	@BodyOfKnowledgeId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

	IF 	(@StrategyHistoryId IS NULL AND @StrategyId IS NULL AND @BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600,-1,-1, 'Missing pramiters');
	END
	IF 	(@StrategyHistoryId IS NOT NULL AND @StrategyId IS NOT NULL AND @BodyOfKnowledgeId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId,LH.StrategyId, LH.BodyOfKnowledgeId,
			LH.Name, BOK.Name AS BodyOfKnowledgeName,LH.Description,
			SortRuleId,LH.QuestionSelection, LH.ResponseSelection, 
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate, 
			LH.NumberOfTimesTried,LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredIncorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE LH.StrategyHistoryId=@StrategyHistoryId
			AND LH.StrategyId=@StrategyId
			AND LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
			AND u.Originator = @Originator

		END
	ELSE IF (@StrategyHistoryId IS NULL AND @StrategyId IS NOT NULL AND @BodyOfKnowledgeId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId,LH.StrategyId,LH.BodyOfKnowledgeId,LH.Name,LH.Description,
			 BOK.Name AS BodyOfKnowledgeName,SortRuleId,LH.QuestionSelection, LH.ResponseSelection, 
			FirstLearningRunDate, LH.LastModifiedOffset, LH.CloudRowId,LastQuestionId,NumberOfTimesTried,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredIncorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE LH.StrategyId=@StrategyId
			AND LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
			AND u.Originator = @Originator
		END
	ELSE
		BEGIN 
			SELECT LH.StrategyHistoryId,LH.StrategyId,LH.BodyOfKnowledgeId,LH.Name,LH.Description,LH.SortRuleId, BOK.Name AS BodyOfKnowledgeName,
			LH.QuestionSelection, LH.ResponseSelection, LH.FirstLearningRunDate,LH.LastModifiedOffset,LH.CloudRowId,LastQuestionId,NumberOfTimesTried,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredIncorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
			AND u.Originator = @Originator
		END
RETURN 0