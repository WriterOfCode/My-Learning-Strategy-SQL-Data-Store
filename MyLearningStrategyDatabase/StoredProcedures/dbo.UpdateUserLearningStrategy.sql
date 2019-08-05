CREATE PROCEDURE [dbo].[UpdateUserLearningStrategy]
	@StrategyId INT,
    @BodyOfKnowledgeId INT, 
	@Name NVARCHAR(150) NULL, 
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
	@OnlyCorrect BIT,
	@Originator UNIQUEIDENTIFIER
AS

DECLARE @rowsaffected INT 

	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	
	BEGIN
		UPDATE [dbo].[LearningStrategies]
		SET Name=@Name, 
			Description=ISNULL(@Description,@Name), 
			SortRuleId=@SortRuleId, 
			QuestionRandom=@QuestionRandom, 
			QuestionMax=@QuestionMax, 
			QuestionMin=@QuestionMin, 
			ResponseRandom=@ResponseRandom, 
			ResponseMax=@ResponseMax, 
			ResponseMin=@ResponseMin, 
			ResponseMinCorrect=@ResponseMinCorrect, 
			ResponseMaxCorrect=@ResponseMaxCorrect, 
			OnlyCorrect = @OnlyCorrect,
			LastModifiedOffset=SYSDATETIMEOFFSET()
		WHERE StrategyId = @StrategyId 
		AND BodyOfKnowledgeId=@BodyOfKnowledgeId

		SET @rowsaffected = @@ROWCOUNT
			
	END
return 	@rowsaffected