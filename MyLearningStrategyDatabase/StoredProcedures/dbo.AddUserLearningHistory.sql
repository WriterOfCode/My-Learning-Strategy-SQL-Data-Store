﻿CREATE PROCEDURE [dbo].[AddUserLearningHistory]
	@StrategyId INT, 
	@Originator uniqueidentifier
AS
    DECLARE @BodyOfKnowledgeId INT
	DECLARE @StrategyHistoryId INT 

	SELECT @BodyOfKnowledgeId = BodyOfKnowledgeId  
	FROM LearningStrategies 
	WHERE StrategyId=@StrategyId

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');  
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	
	BEGIN
		INSERT INTO [dbo].[LearningHistory]
		(StrategyId,
			BodyOfKnowledgeId, 
			Description, 
			SortRuleId, 
			QuestionRandom, 
			QuestionMax, 
			QuestionMin, 
			ResponseRandom, 
			ResponseMax, 
			ResponseMin, 
			ResponseMinCorrect, 
			ResponseMaxCorrect)
		SELECT StrategyId,
			BodyOfKnowledgeId, 
			Description, 
			SortRuleId, 
			QuestionRandom, 
			QuestionMax, 
			QuestionMin, 
			ResponseRandom, 
			ResponseMax, 
			ResponseMin, 
			ResponseMinCorrect, 
			ResponseMaxCorrect
		FROM [dbo].[LearningStrategies] LS
		WHERE LS.StrategyId= @StrategyId;
		
		SELECT CAST(SCOPE_IDENTITY() AS INT) AS StrategyHistoryId;
	END
return 	@StrategyHistoryId