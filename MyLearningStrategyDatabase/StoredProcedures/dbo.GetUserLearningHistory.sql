CREATE PROCEDURE [dbo].[GetUserLearningHistory]
	@StrategyHistoryId INT NULL , 
	@StrategyId INT NULL ,
	@BodyOfKnowledgeId INT NULL
AS

	IF 	(@StrategyHistoryId IS NULL AND @StrategyId IS NULL AND @BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600,-1,-1, 'Missing pramiters');
	END
	IF (@StrategyHistoryId IS NOT NULL)
		BEGIN 
			SELECT StrategyHistoryId,StrategyId,BodyOfKnowledgeId,Name,Description,SortRuleId,QuestionRandom,
			QuestionMax,QuestionMin,ResponseRandom,ResponseMax,ResponseMin,ResponseMinCorrect,OnlyCorrect,
			ResponseMaxCorrect,LearningRunDate,LastModifiedOffset,CloudRowId,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH WHERE StrategyHistoryId=@StrategyHistoryId
		END
	ELSE IF (@StrategyId IS NOT NULL)
		BEGIN 
			SELECT StrategyHistoryId,StrategyId,BodyOfKnowledgeId,Name,Description,SortRuleId,QuestionRandom,
			QuestionMax,QuestionMin,ResponseRandom,ResponseMax,ResponseMin,ResponseMinCorrect,OnlyCorrect,
			ResponseMaxCorrect,LearningRunDate,LastModifiedOffset,CloudRowId,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH WHERE StrategyId=@StrategyId
		END
	ELSE
		BEGIN 
			SELECT StrategyHistoryId,StrategyId,BodyOfKnowledgeId,Name,Description,SortRuleId,QuestionRandom,
			QuestionMax,QuestionMin,ResponseRandom,ResponseMax,ResponseMin,ResponseMinCorrect,OnlyCorrect,
			ResponseMaxCorrect,LearningRunDate,LastModifiedOffset,CloudRowId,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredCorrectly,
			(SELECT isnull(SUM(LP.AnsweredCorrectlyCount),0) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS AnsweredIncorrectly,
			(SELECT COUNT(*) FROM LearningHistoryProgress LP WHERE LH.StrategyHistoryId = LP.StrategyHistoryId) AS Answered
			FROM LearningHistory LH WHERE LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
		END
RETURN 0

