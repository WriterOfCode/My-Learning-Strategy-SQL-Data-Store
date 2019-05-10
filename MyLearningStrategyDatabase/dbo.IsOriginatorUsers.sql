CREATE FUNCTION [dbo].[IsOriginatorUsers]
(
	@UserProfileId int,
	@Originator uniqueidentifier
)
RETURNS INT
AS
BEGIN
	DECLARE @bokCount INT
	DECLARE @adminCount INT

	--INSERT INTO @bokCount
	SELECT @bokCount = COUNT(*)
	FROM [UserProfiles]
	WHERE UserProfileId = @UserProfileId
	AND Originator = @Originator;

	--INSERT INTO @adminCount
	SELECT @adminCount = COUNT(*)
	FROM [dbo].[UserPermissions]
	WHERE UserProfileId = @UserProfileId
	AND ClaimType LIKE 'Admin%'

	RETURN @bokCount + @adminCount
END
