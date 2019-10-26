CREATE PROCEDURE [dbo].[UpdateUserStrategy]
	@StrategyId INT,
    @UserProfileId INT, 
	@Name NVARCHAR(150), 
    @Description NVARCHAR(256) NULL, 
    @SortRuleId INT, 
    @QuestionSelection INT, 
    @ResponseSelection INT, 
	@OnlyCorrect BIT,
	@RecycleIncorrectlyAnswered BIT,
	@Originator UNIQUEIDENTIFIER
AS

DECLARE @rowsaffected INT 

	--IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	--BEGIN
	--	RAISERROR (13538,14,-1, 'User is not the owner!');   
	--END
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)
	BEGIN
		UPDATE [dbo].[Strategies]
		SET Name=@Name, 
			UserProfileId=@UserProfileId, 
			Description=ISNULL(@Description,@Name), 
			SortRuleId=@SortRuleId, 
			QuestionSelection=@QuestionSelection, 
			ResponseSelection=@ResponseSelection,
			OnlyCorrect=@OnlyCorrect, 
			RecycleIncorrectlyAnswered=@RecycleIncorrectlyAnswered,
			LastModifiedOffset=SYSDATETIMEOFFSET()
		WHERE StrategyId=@StrategyId 
		AND UserProfileId=@UserProfileId;

		SET @rowsaffected=@@ROWCOUNT
	END
return 	@rowsaffected
