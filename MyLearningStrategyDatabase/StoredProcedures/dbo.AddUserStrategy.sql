CREATE PROCEDURE [dbo].[AddUserStrategy]
    @UserProfileId INT, 
	@Name NVARCHAR(150) , 
    @Description NVARCHAR(256), 
    @SortRuleId INT, 
    @QuestionSelection INT NULL, 
    @ResponseSelection INT NULL, 
	@OnlyCorrect BIT,
	@RecycleIncorrectlyAnswered BIT, 
	@Originator uniqueidentifier
AS
	DECLARE	@StrategyId INT; 
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)
	IF (@UserProfileId is null)
	BEGIN
		RAISERROR (13538,14,-1, 'User not found!');   
	END
	BEGIN
		INSERT INTO [dbo].[Strategies]
			(Name,
			UserProfileId, 
			Description, 
			SortRuleId,  
			QuestionSelection,
			ResponseSelection,
			OnlyCorrect,
			RecycleIncorrectlyAnswered)
		VALUES (@Name,
				@UserProfileId, 
				ISNULL(@Description,@Name), 
				@SortRuleId, 
				@QuestionSelection, 
				@ResponseSelection, 
				@OnlyCorrect,
				@RecycleIncorrectlyAnswered);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END
return