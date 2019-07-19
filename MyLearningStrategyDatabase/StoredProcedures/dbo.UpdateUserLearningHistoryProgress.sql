CREATE PROCEDURE [dbo].[UpdateUserLearningHistoryProgress]
	@LearningHistoryProgressId INT,
	@StrategyHistoryId INT, 
	@QuestionId INT, 
	@AnsweredIncorrectlyCount INT, 
	@AnsweredCorrectlyCount INT,
	@Originator UNIQUEIDENTIFIER
AS

MERGE LearningHistoryProgress t
    USING (select @LearningHistoryProgressId as LearningHistoryProgressId,
			@StrategyHistoryId as StrategyHistoryId, 
			@QuestionId as QuestionId , 
			@AnsweredIncorrectlyCount as AnsweredIncorrectlyCount, 
			@AnsweredCorrectlyCount as AnsweredCorrectlyCount) s
	ON (t.LearningHistoryProgressId=s.LearningHistoryProgressId
			AND t.StrategyHistoryId =s.StrategyHistoryId 
			AND t.QuestionId=s.QuestionId)
WHEN MATCHED
    THEN UPDATE SET 
		--t.AnsweredIncorrectlyCount = t.AnsweredIncorrectlyCount + s.AnsweredIncorrectlyCount,
		--t.AnsweredCorrectlyCount = t.AnsweredCorrectlyCount + s.AnsweredCorrectlyCount
		t.AnsweredIncorrectlyCount =@AnsweredIncorrectlyCount,
		t.AnsweredCorrectlyCount = @AnsweredCorrectlyCount
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(LearningHistoryProgressId,
			StrategyHistoryId, QuestionId, 
			AnsweredIncorrectlyCount, 
			AnsweredCorrectlyCount)
		VALUES (s.LearningHistoryProgressId,
			s.StrategyHistoryId, s.QuestionId, 
			s.AnsweredIncorrectlyCount, 
			s.AnsweredCorrectlyCount);

		--SET @ResponseId = CAST(SCOPE_IDENTITY() AS INT)
		SELECT CAST(SCOPE_IDENTITY() AS INT) AS ResponseId;
RETURN 0
