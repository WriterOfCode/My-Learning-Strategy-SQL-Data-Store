CREATE FUNCTION [dbo].[IsOriginatorAdmin]
(
	@Originator uniqueidentifier
)
RETURNS INT
AS
BEGIN
	DECLARE @adminCount INT

	SELECT @adminCount = COUNT(*)
	FROM [dbo].[UserPermissions] p
	join [dbo].[UserProfiles] u
	on p.UserProfileId=u.UserProfileId
	WHERE ClaimType LIKE 'Admin%'
	AND Originator = @Originator;

	RETURN @adminCount
END