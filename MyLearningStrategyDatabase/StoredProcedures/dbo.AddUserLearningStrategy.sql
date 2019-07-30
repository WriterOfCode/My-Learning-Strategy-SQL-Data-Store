CREATE PROCEDURE [dbo].[AddUserLearningStrategy]
    @BodyOfKnowledgeId INT, 
	@Name NVARCHAR(150) , 
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
		--INSERT INTO [dbo].[LearningStrategies]
		--	(Name,
		--	BodyOfKnowledgeId, 
		--	Description, 
		--	SortRuleId, 
		--	QuestionRandom, 
		--	QuestionMax, 
		--	QuestionMin, 
		--	ResponseRandom, 
		--	ResponseMax, 
		--	ResponseMin, 
		--	ResponseMinCorrect, 
		--	ResponseMaxCorrect)
		--VALUES (@Name,
		--		@BodyOfKnowledgeId, 
		--		ISNULL(@Description,@Name), 
		--		@SortRuleId, 
		--		@QuestionRandom, 
		--		@QuestionMax, 
		--		@QuestionMin, 
		--		@ResponseRandom, 
		--		@ResponseMax, 
		--		@ResponseMin, 
		--		@ResponseMinCorrect, 
		--		@ResponseMaxCorrect);

		--SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;


		


		MERGE [dbo].[LearningStrategies] t
		USING (select @Name AS Name,
				@BodyOfKnowledgeId AS BodyOfKnowledgeId, 
				ISNULL(@Description,@Name) AS Description, 
				@SortRuleId AS SortRuleId, 
				@QuestionRandom AS QuestionRandom, 
				@QuestionMax AS QuestionMax, 
				@QuestionMin AS QuestionMin, 
				@ResponseRandom AS ResponseRandom, 
				@ResponseMax AS ResponseMax, 
				@ResponseMin AS ResponseMin, 
				@ResponseMinCorrect AS ResponseMinCorrect, 
				@ResponseMaxCorrect AS ResponseMaxCorrect) s
		ON (t.BodyOfKnowledgeId=s.BodyOfKnowledgeId)
	WHEN MATCHED
		THEN UPDATE SET t.Name = s.Name,
				t.BodyOfKnowledgeId = s.BodyOfKnowledgeId, 
				t.Description = s.Description, 
				t.SortRuleId = s.SortRuleId,
				t.QuestionRandom = s.QuestionRandom,
				t.QuestionMax = s.QuestionMax,
				t.QuestionMin = s.QuestionMin,
				t.ResponseRandom = s.ResponseRandom,
				t.ResponseMax = s.ResponseMax,
				t.ResponseMin = s.ResponseMin,
				t.ResponseMinCorrect = s.ResponseMinCorrect,
				t.ResponseMaxCorrect = s.ResponseMaxCorrect
	WHEN NOT MATCHED BY TARGET 
		THEN INSERT(Name,
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
		VALUES (@Name,
				@BodyOfKnowledgeId, 
				ISNULL(@Description,@Name), 
				@SortRuleId, 
				@QuestionRandom, 
				@QuestionMax, 
				@QuestionMin, 
				@ResponseRandom, 
				@ResponseMax, 
				@ResponseMin, 
				@ResponseMinCorrect, 
				@ResponseMaxCorrect);
		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue
	END
return