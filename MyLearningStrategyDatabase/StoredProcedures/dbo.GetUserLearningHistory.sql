CREATE PROCEDURE [dbo].[GetUserLearningHistory]
	@StrategyHistoryId INT NULL , 
	@StrategyId INT NULL ,
	@BodyOfKnowledgeId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF 	(@StrategyHistoryId IS NULL AND @StrategyId IS NULL AND @BodyOfKnowledgeId IS NULL)
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
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE u.Originator = @Originator
	END
	ELSE IF (@StrategyHistoryId IS NOT NULL)
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
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE StrategyHistoryId=@StrategyHistoryId
			and u.Originator = @Originator
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
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE StrategyId=@StrategyId
			and u.Originator = @Originator

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
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
			and u.Originator = @Originator
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
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE u.Originator = @Originator

		END
RETURN 0