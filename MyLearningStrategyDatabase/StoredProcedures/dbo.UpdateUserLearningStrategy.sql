CREATE PROCEDURE [dbo].[UpdateUserLearningStrategy]
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
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@Originator UNIQUEIDENTIFIER
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
			ResponseMaxCorrect, 
			LastModifiedOffset)
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
				@ResponseMaxCorrect, 
				@LastModifiedOffset);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS StrategyId;
	END
return 	@StrategyId