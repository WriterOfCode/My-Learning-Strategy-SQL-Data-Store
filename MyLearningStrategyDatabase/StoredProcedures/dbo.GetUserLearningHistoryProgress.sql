CREATE PROCEDURE [dbo].[GetUserLearningHistoryProgress]
	@StrategyHistoryId INT NULL , 
	@StrategyId INT NULL ,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@StrategyHistoryId IS NOT NULL)
		BEGIN 
			SELECT LP.LearningHistoryProgressId ,
			LP.StrategyHistoryId , 
			LP.QuestionId, 
			LP.AnsweredIncorrectlyCount , 
			LP.AnsweredCorrectlyCount, 
			LP.NumberOfTimes, 
			LP.LastModifiedOffset, 
			LP.CloudRowId, 
			@Originator AS Originator
			FROM LearningHistoryProgress LP 
			JOIN LearningHistory LH  ON LH.StrategyHistoryId=LP.StrategyHistoryId
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE LH.StrategyHistoryId=@StrategyHistoryId
			AND u.Originator = @Originator;
		END
	ELSE IF (@StrategyId IS NOT NULL)
		BEGIN 
			SELECT LP.LearningHistoryProgressId ,
			LP.StrategyHistoryId , 
			LP.QuestionId, 
			LP.AnsweredIncorrectlyCount , 
			LP.AnsweredCorrectlyCount, 
			LP.NumberOfTimes, 
			LP.LastModifiedOffset, 
			LP.CloudRowId, 
			@Originator AS Originator
			FROM LearningHistoryProgress LP 
			JOIN LearningHistory LH  ON LH.StrategyHistoryId=LP.StrategyHistoryId
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE u.Originator = @Originator
			AND LH.StrategyId=@StrategyId;
		END
	ELSE If (@StrategyHistoryId IS NULL 
			AND @StrategyId IS NULL )
		BEGIN 
			SELECT LP.LearningHistoryProgressId ,
			LP.StrategyHistoryId , 
			LP.QuestionId, 
			LP.AnsweredIncorrectlyCount , 
			LP.AnsweredCorrectlyCount, 
			LP.NumberOfTimes, 
			LP.LastModifiedOffset, 
			LP.CloudRowId, 
			@Originator AS Originator
			FROM LearningHistoryProgress LP 
			JOIN LearningHistory LH  ON LH.StrategyHistoryId=LP.StrategyHistoryId
			JOIN BodyOfKnowledge BOK ON LH.BodyOfKnowledgeId = BOK.BodyOfKnowledgeId
			JOIN UserProfiles u on u.UserProfileId = BOK.UserProfileId
			WHERE  u.Originator = @Originator;
		END
RETURN 0