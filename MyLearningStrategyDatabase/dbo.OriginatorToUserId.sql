CREATE FUNCTION [dbo].[OriginatorToUserId]
(
	@Originator uniqueidentifier
)
RETURNS INT
AS
BEGIN
	DECLARE @UserProfileId INT

	SELECT @UserProfileId = MAX(UP.UserProfileId)
	FROM UserProfiles UP 
	WHERE UP.Originator = @Originator

	RETURN @UserProfileId
END