CREATE PROCEDURE [dbo].[AddUserLearningStrategy]
    @BodyOfKnowledgeId INT, 
    @Description NVARCHAR(256), 
    @SortRuleId INT, 
    @QuestionRandom BIT, 
    @QuestionMax INT NULL, 
    @QuestionMin INT NULL, 
    @ResponseRandom BIT NULL, 
    @ResponseMax INT NULL, 
    @ResponseMin INT NULL, 
    @ResponseMinCorrect INT NULL, 
    @ResponseMaxCorrect INT NULL, 
	@Originator uniqueidentifier
AS
	DECLARE	@StrategyId INT; 

	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	
	BEGIN
		INSERT INTO [dbo].[LearningStrategies]
			(BodyOfKnowledgeId, 
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
		VALUES (@BodyOfKnowledgeId, 
				@Description, 
				@SortRuleId, 
				@QuestionRandom, 
				@QuestionMax, 
				@QuestionMin, 
				@ResponseRandom, 
				@ResponseMax, 
				@ResponseMin, 
				@ResponseMinCorrect, 
				@ResponseMaxCorrect);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END
return