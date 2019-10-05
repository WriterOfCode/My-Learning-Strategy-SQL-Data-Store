CREATE PROCEDURE [dbo].[DeleteUserStrategy]
	@StrategyId INT NULL , 
	@UserProfileId INT
AS


IF (@StrategyId IS NULL)
	BEGIN
	DELETE FROM [dbo].[Strategies]
	WHERE UserProfileId=@UserProfileId
	END
ELSE
	BEGIN
		DELETE FROM [dbo].[Strategies]
		WHERE UserProfileId=@UserProfileId
		AND StrategyId=@StrategyId
	END
RETURN 0
