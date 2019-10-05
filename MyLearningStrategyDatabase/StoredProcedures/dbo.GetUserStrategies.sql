CREATE PROCEDURE [dbo].[GetUserStrategies]
	@StrategyId INT NULL,
	@UserProfileId INT,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsOriginatorUsers](@UserProfileId, @Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	IF @StrategyId IS NULL
	BEGIN
		SELECT 	StrategyId, 
			UserProfileId,Name,Description,SortRuleId, 
			QuestionRandom,QuestionMax,QuestionMin, 
			ResponseRandom , ResponseMax, ResponseMin, 
			ResponseMinCorrect,ResponseMaxCorrect,OnlyCorrect,
			LastModifiedOffset,CloudRowId
		FROM [dbo].[Strategies]
		WHERE UserProfileId=@UserProfileId
	END
	ELSE
	BEGIN
		SELECT 	StrategyId, 
			UserProfileId,Name,Description,SortRuleId, 
			QuestionRandom,QuestionMax,QuestionMin, 
			ResponseRandom , ResponseMax, ResponseMin, 
			ResponseMinCorrect,ResponseMaxCorrect,OnlyCorrect,
			LastModifiedOffset,CloudRowId
		FROM [dbo].[Strategies]
		WHERE UserProfileId=@UserProfileId
		AND StrategyId=@StrategyId
	END
RETURN 0