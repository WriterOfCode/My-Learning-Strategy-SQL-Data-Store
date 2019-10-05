CREATE PROCEDURE [dbo].[GetUserLearningHistory]
	@StrategyHistoryId INT NULL , 
	@StrategyId INT NULL ,
	@BodyOfKnowledgeId INT NULL,
	@UserProfileId INT NULL
AS

	IF 	(@StrategyHistoryId IS NULL AND @StrategyId IS NULL AND @BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600,-1,-1, 'Missing pramiters');
	END
	IF (@StrategyHistoryId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId, LH.StrategyId, LH.BodyOfKnowledgeId, LH.Name, BOK.Name,
			LH.Description, LH.SortRuleId, LH.QuestionRandom, LH.QuestionMax, 
			LH.QuestionMin, LH.ResponseRandom, LH.ResponseMax, LH.ResponseMin, 
			LH.ResponseMinCorrect, LH.ResponseMaxCorrect, LH.OnlyCorrect,
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate,
			LH.NumberOfTimesTried, LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId 
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			WHERE StrategyHistoryId=@StrategyHistoryId
		END
	ELSE IF (@StrategyId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId, LH.StrategyId, LH.BodyOfKnowledgeId, LH.Name,
			LH.Description, LH.SortRuleId, LH.QuestionRandom, LH.QuestionMax, 
			LH.QuestionMin, LH.ResponseRandom, LH.ResponseMax, LH.ResponseMin, 
			LH.ResponseMinCorrect, LH.ResponseMaxCorrect, LH.OnlyCorrect,
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate,
			LH.NumberOfTimesTried, LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId 
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			WHERE StrategyId=@StrategyId
		END
	ELSE IF (@BodyOfKnowledgeId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId, LH.StrategyId, LH.BodyOfKnowledgeId, LH.Name,
			LH.Description, LH.SortRuleId, LH.QuestionRandom, LH.QuestionMax, 
			LH.QuestionMin, LH.ResponseRandom, LH.ResponseMax, LH.ResponseMin, 
			LH.ResponseMinCorrect, LH.ResponseMaxCorrect, LH.OnlyCorrect,
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate,
			LH.NumberOfTimesTried, LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId 
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			WHERE LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
		END
	ELSE 
		BEGIN
			SELECT LH.StrategyHistoryId, LH.StrategyId, LH.BodyOfKnowledgeId, LH.Name, 
			LH.Description, LH.SortRuleId, LH.QuestionRandom, LH.QuestionMax, 
			LH.QuestionMin, LH.ResponseRandom, LH.ResponseMax, LH.ResponseMin, 
			LH.ResponseMinCorrect, LH.ResponseMaxCorrect, LH.OnlyCorrect,
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate,
			LH.NumberOfTimesTried, LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId 
			FROM LearningHistory LH
			JOIN Strategies LS ON LS.StrategyId = LH.StrategyId
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			WHERE LS.UserProfileId=@UserProfileId
		END
RETURN 0