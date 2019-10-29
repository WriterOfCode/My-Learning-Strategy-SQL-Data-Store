CREATE PROCEDURE [dbo].[GetUserLearningHistory]
	@StrategyHistoryId INT NULL , 
	@StrategyId INT NULL ,
	@BodyOfKnowledgeId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@StrategyId IS NOT NULL AND @BodyOfKnowledgeId IS NOT NULL AND @StrategyHistoryId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId, LH.StrategyId, LH.BodyOfKnowledgeId, LH.Name, 
			LH.Description, LH.SortRuleId, LH.QuestionSelection, LH.ResponseSelection, 
			LH.OnlyCorrect,
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate,
			LH.NumberOfTimesTried, LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId 
			FROM LearningHistory LH
			JOIN Strategies LS ON LS.StrategyId = LH.StrategyId
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE LH.StrategyHistoryId=@StrategyHistoryId
			and LH.StrategyId=@StrategyId
			and LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
			and u.Originator = @Originator
		END
	ELSE IF (@StrategyId IS NOT NULL AND @BodyOfKnowledgeId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId, LH.StrategyId, LH.BodyOfKnowledgeId, LH.Name,
			LH.Description, LH.SortRuleId, LH.QuestionSelection, LH.ResponseSelection, 
			LH.OnlyCorrect,
			LH.RecycleIncorrectlyAnswered, LH.FirstLearningRunDate,
			LH.NumberOfTimesTried, LH.LastQuestionId, LH.LastModifiedOffset, 
			LH.CloudRowId 
			FROM LearningHistory LH 
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE LH.StrategyId=@StrategyId
			and LH.BodyOfKnowledgeId=@BodyOfKnowledgeId
			and u.Originator = @Originator
		END
	ELSE IF (@BodyOfKnowledgeId IS NOT NULL)
		BEGIN 
			SELECT LH.StrategyHistoryId, LH.StrategyId, LH.BodyOfKnowledgeId, LH.Name,
			LH.Description, LH.SortRuleId,LH.QuestionSelection, LH.ResponseSelection,
			LH.OnlyCorrect,
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
			LH.Description, LH.SortRuleId, LH.QuestionSelection, LH.ResponseSelection, 
			LH.OnlyCorrect,
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