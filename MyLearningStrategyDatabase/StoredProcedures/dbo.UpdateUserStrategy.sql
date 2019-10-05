CREATE PROCEDURE [dbo].[UpdateUserStrategy]
	@StrategyId INT,
    @UserProfileId INT, 
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
	@RecycleIncorrectlyAnswered BIT,
	@Originator UNIQUEIDENTIFIER
AS

DECLARE @rowsaffected INT 

	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		UPDATE [dbo].[Strategies]
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
			RecycleIncorrectlyAnswered = @RecycleIncorrectlyAnswered,
			LastModifiedOffset=SYSDATETIMEOFFSET()
		WHERE StrategyId = @StrategyId 
		AND UserProfileId=@UserProfileId

		SET @rowsaffected = @@ROWCOUNT
			
	END
return 	@rowsaffected
