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


	RETURN @UserProfileId
END