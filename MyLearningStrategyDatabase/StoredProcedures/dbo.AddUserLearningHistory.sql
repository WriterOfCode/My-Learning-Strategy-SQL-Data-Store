﻿CREATE PROCEDURE [dbo].[AddUserLearningHistory]
	@StrategyId INT, 
	@BodyOfKnowledgeId INT,
	@Originator uniqueidentifier
AS

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
			Name,
			BodyOfKnowledgeId, 
			Description, 
			SortRuleId,
			QuestionSelection,
			ResponseSelection,
			RecycleIncorrectlyAnswered)
		SELECT StrategyId,
			Name,
			@BodyOfKnowledgeId, 
			Description, 
			SortRuleId,  
			QuestionSelection,
			ResponseSelection,
			RecycleIncorrectlyAnswered
		FROM [dbo].[Strategies] LS
		WHERE LS.StrategyId= @StrategyId

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END
return