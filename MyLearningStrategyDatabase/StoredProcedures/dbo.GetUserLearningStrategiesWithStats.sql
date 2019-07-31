CREATE PROCEDURE [dbo].[GetUserLearningStrategiesWithStats]
    @BodyOfKnowledgeId INT NULL,
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
			ResponseMinCorrect,ResponseMaxCorrect,
			LastModifiedOffset,CloudRowId,
			(SELECT COUNT(*) FROM  [dbo].[Questions] q 
				WHERE  q.BodyOfKnowledgeId =s.BodyOfKnowledgeId) As MaxQuestions,
			(SELECT COUNT(*) FROM Responses r join Questions q on q.QuestionId =r.QuestionId
				WHERE q.BodyOfKnowledgeId = s.BodyOfKnowledgeId) As MaxResponseses
		FROM [dbo].[LearningStrategies] s
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
	END
	ELSE
	BEGIN
		SELECT 	s.StrategyId, 
			BodyOfKnowledgeId,Name,Description,SortRuleId, 
			QuestionRandom,QuestionMax,QuestionMin, 
			ResponseRandom , ResponseMax, ResponseMin, 
			ResponseMinCorrect,ResponseMaxCorrect,
			LastModifiedOffset,CloudRowId,
			(SELECT COUNT(*) FROM  [dbo].[Questions] q 
				WHERE  q.BodyOfKnowledgeId =s.BodyOfKnowledgeId) As MaxQuestions,
			(SELECT COUNT(*) FROM Responses r join Questions q on q.QuestionId =r.QuestionId
				WHERE q.BodyOfKnowledgeId = s.BodyOfKnowledgeId) As MaxResponseses
		FROM [dbo].[LearningStrategies] s
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
		AND StrategyId=@StrategyId
	END
RETURN 0