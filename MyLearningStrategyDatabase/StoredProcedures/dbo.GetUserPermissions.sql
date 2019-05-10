CREATE PROCEDURE [dbo].[GetUserPermissions]
	@PermissionsId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
IF (@Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserPermissions.@Originator');   
END

IF (@PermissionsId IS NULL)
BEGIN
	SELECT up.PermissionsId,u.Originator,up.ClaimType,up.ClaimValue
	FROM UserPermissions  up
	JOIN UserProfiles u ON u.UserProfileId = up.UserProfileId
	WHERE u.Originator=@Originator;
END
ELSE
BEGIN
	SELECT up.PermissionsId,u.Originator,up.ClaimType,up.ClaimValue
	FROM UserPermissions  up
	JOIN UserProfiles u ON u.UserProfileId = up.UserProfileId
	WHERE u.Originator=@Originator
	AND up.PermissionsId = @PermissionsId;
END

RETURN 0
