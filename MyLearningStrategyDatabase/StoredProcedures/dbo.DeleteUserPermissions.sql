CREATE PROCEDURE [dbo].[DeleteUserPermissions]
	@UserProfileId INT NULL,
	@PermissionsId INT NULL
AS
IF (@UserProfileId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, '[DeleteUserPermissions].@UserProfileId');   
END
	IF (@PermissionsId IS NULL)
		BEGIN
			DELETE
			FROM [dbo].[UserPermissions]
			WHERE UserProfileId = @UserProfileId;
		END
	ELSE
		BEGIN 
			DELETE
			FROM [dbo].[UserPermissions]
			WHERE UserProfileId = @UserProfileId
			AND  PermissionsId = @PermissionsId;
		END
RETURN 0
