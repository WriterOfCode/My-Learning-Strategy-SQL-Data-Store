CREATE PROCEDURE [dbo].[GetUserStrategies]
	@StrategyId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF @StrategyId IS NULL
	BEGIN
		SELECT 	S.StrategyId, 
			S.UserProfileId,S.Name,S.Description,S.SortRuleId, 
			S.QuestionRandom,S.QuestionMax,S.QuestionMin, 
			S.ResponseRandom , S.ResponseMax, S.ResponseMin, 
			S.ResponseMinCorrect,S.ResponseMaxCorrect,S.OnlyCorrect,
			S.LastModifiedOffset,S.CloudRowId
		FROM [dbo].[Strategies] S
		JOIN UserProfiles UP ON UP.UserProfileId=S.UserProfileId
        WHERE UP.Originator = @Originator
	END
	ELSE
	BEGIN
		SELECT 	S.StrategyId, 
			S.UserProfileId,S.Name,S.Description,S.SortRuleId, 
			S.QuestionRandom,S.QuestionMax,S.QuestionMin, 
			S.ResponseRandom , S.ResponseMax, S.ResponseMin, 
			S.ResponseMinCorrect,S.ResponseMaxCorrect,S.OnlyCorrect,
			S.LastModifiedOffset,S.CloudRowId
		FROM [dbo].[Strategies] S
		JOIN UserProfiles UP ON UP.UserProfileId=S.UserProfileId
        WHERE UP.Originator = @Originator
		AND S.StrategyId=@StrategyId
	END
RETURN 0