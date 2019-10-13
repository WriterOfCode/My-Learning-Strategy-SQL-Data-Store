CREATE PROCEDURE [dbo].[DeleteUserLearningStrategy]
	@StrategyId INT NULL , 
	@Originator UNIQUEIDENTIFIER NULL
AS


DECLARE @UserProfileId INT
SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

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
