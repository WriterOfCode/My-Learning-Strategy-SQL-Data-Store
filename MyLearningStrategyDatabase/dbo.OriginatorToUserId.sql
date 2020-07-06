CREATE FUNCTION [dbo].[OriginatorToUserId]
(
	@Originator uniqueidentifier
)
RETURNS INT
AS
BEGIN
	DECLARE @UserProfileId INT
 

	SELECT @UserProfileId = UserProfileId
	FROM UserProfiles 
	WHERE Originator = @Originator;

	IF (@UserProfileId is null)
	BEGIN
		RAISERROR (13538,14,-1, 'User not found!');   
	END
	RETURN @UserProfileId
END