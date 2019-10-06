CREATE PROCEDURE [dbo].[AddUserStrategy]
    @UserProfileId INT, 
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
	@OnlyCorrect BIT,
	@RecycleIncorrectlyAnswered BIT, 
	@Originator uniqueidentifier
AS
	DECLARE	@StrategyId INT; 




	IF ([dbo].[IsBokOriginator](@Originator,@UserProfileId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	
	BEGIN
		INSERT INTO [dbo].[Strategies]
			(Name,
			UserProfileId, 
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
			OnlyCorrect,
			RecycleIncorrectlyAnswered)
		VALUES (@Name,
				@UserProfileId, 
				ISNULL(@Description,@Name), 
				@SortRuleId, 
				@QuestionRandom, 
				@QuestionMax, 
				@QuestionMin, 
				@ResponseRandom, 
				@ResponseMax, 
				@ResponseMin, 
				@ResponseMinCorrect, 
				@ResponseMaxCorrect,
				@OnlyCorrect,
				@RecycleIncorrectlyAnswered);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END
return