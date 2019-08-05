CREATE PROCEDURE [dbo].[GetUserLearningStrategies]
    @BodyOfKnowledgeId INT,
	@StrategyId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId )=0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END
	IF @StrategyId IS NULL
	BEGIN
		SELECT 	StrategyId, 
			BodyOfKnowledgeId,Name,Description,SortRuleId, 
			QuestionRandom,QuestionMax,QuestionMin, 
			ResponseRandom , ResponseMax, ResponseMin, 
			ResponseMinCorrect,ResponseMaxCorrect,OnlyCorrect,
			LastModifiedOffset,CloudRowId
		FROM [dbo].[LearningStrategies]
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
	END
	ELSE
	BEGIN
		SELECT 	StrategyId, 
			BodyOfKnowledgeId,Name,Description,SortRuleId, 
			QuestionRandom,QuestionMax,QuestionMin, 
			ResponseRandom , ResponseMax, ResponseMin, 
			ResponseMinCorrect,ResponseMaxCorrect,OnlyCorrect,
			LastModifiedOffset,CloudRowId
		FROM [dbo].[LearningStrategies]
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
		AND StrategyId=@StrategyId
	END
RETURN 0