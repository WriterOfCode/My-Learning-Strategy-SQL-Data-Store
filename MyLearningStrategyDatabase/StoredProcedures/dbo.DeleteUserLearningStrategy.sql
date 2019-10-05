﻿CREATE PROCEDURE [dbo].[DeleteUserLearningStrategy]
	@StrategyId INT NULL , 
    @UserProfileId INT NULL,
	@Originator UNIQUEIDENTIFIER NULL
AS

IF ([dbo].[IsOriginatorUsers](@UserProfileId, @Originator)=0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END
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
