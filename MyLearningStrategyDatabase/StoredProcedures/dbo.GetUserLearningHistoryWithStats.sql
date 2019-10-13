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
	IF (@StrategyHistoryId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId,LH.StrategyId, LH.BodyOfKnowledgeId,LH.Name, 
			BOK.Name AS BodyOfKnowledgeName,
			LH.Description,SortRuleId,QuestionRandom, LH.QuestionMax,
			LH.QuestionMin,	LH.ResponseRandom, LH.ResponseMax, LH.ResponseMin,
			LH.ResponseMinCorrect,LH.ResponseMaxCorrect, LH.OnlyCorrect,
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate, 
			LH.NumberOfTimesTried,LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredIncorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE StrategyHistoryId=@StrategyHistoryId
			AND u.Originator = @Originator

		END
	ELSE IF (@StrategyId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId,LH.StrategyId,LH.BodyOfKnowledgeId,LH.Name,LH.Description,SortRuleId,QuestionRandom, BOK.Name AS BodyOfKnowledgeName,
			QuestionMax,QuestionMin,ResponseRandom,ResponseMax,ResponseMin,ResponseMinCorrect,OnlyCorrect,
			ResponseMaxCorrect, FirstLearningRunDate, LH.LastModifiedOffset, LH.CloudRowId,LastQuestionId,NumberOfTimesTried,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredIncorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			WHERE StrategyId=@StrategyId
		END
	ELSE
		BEGIN 
			SELECT LH.StrategyHistoryId,LH.StrategyId,LH.BodyOfKnowledgeId,LH.Name,LH.Description,LH.SortRuleId,LH.QuestionRandom, BOK.Name AS BodyOfKnowledgeName,
			QuestionMax,QuestionMin,ResponseRandom,ResponseMax,ResponseMin,ResponseMinCorrect,OnlyCorrect,
			LH.ResponseMaxCorrect,LH.FirstLearningRunDate,LH.LastModifiedOffset,LH.CloudRowId,LastQuestionId,NumberOfTimesTried,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredIncorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			WHERE LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
		END
RETURN 0