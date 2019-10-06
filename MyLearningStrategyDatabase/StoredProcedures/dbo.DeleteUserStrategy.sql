CREATE PROCEDURE [dbo].[DeleteUserStrategy]
	@StrategyId INT NULL , 
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @rowsaffected INT 
	DECLARE @UserProfileId INT

	SET @UserProfileId = 
    (
        SELECT UserProfileId FROM UserProfiles 
        WHERE Originator = @Originator
    ) 

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
RETURN 