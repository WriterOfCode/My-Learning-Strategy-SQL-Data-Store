CREATE PROCEDURE [dbo].[GetUserLearningStrategies]
	@StrategyId INT NULL , 
    @BodyOfKnowledgeId INT NULL,
	@Originator UNIQUEIDENTIFIER NULL
AS

IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId )=0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END
IF (@StrategyId IS NULL)
	BEGIN
	SELECT 	StrategyId, 
		BodyOfKnowledgeId,Description,SortRuleId, 
		QuestionRandom,QuestionMax,QuestionMin, 
		ResponseRandom , ResponseMax, ResponseMin, 
		ResponseMinCorrect,ResponseMaxCorrect,
		LastModifiedOffset,CloudRowId
	FROM [dbo].[LearningStrategies]
	WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
	END
ELSE
	BEGIN
		SELECT 	StrategyId, 
		BodyOfKnowledgeId,Description,SortRuleId, 
		QuestionRandom,QuestionMax,QuestionMin, 
		ResponseRandom , ResponseMax, ResponseMin, 
		ResponseMinCorrect,ResponseMaxCorrect,
		LastModifiedOffset,CloudRowId
		FROM [dbo].[LearningStrategies]
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
		AND StrategyId=@StrategyId
	END
RETURN 0
