CREATE FUNCTION [dbo].[OriginatorToUserId]
(
	@Originator uniqueidentifier
)
RETURNS INT
AS
BEGIN
	DECLARE @UserProfileId INT

	SELECT @UserProfileId = ISNULL(MAX(UP.UserProfileId), 0 )
	FROM UserProfiles UP 
	WHERE UP.Originator = @Originator

	RETURN @UserProfileId
END