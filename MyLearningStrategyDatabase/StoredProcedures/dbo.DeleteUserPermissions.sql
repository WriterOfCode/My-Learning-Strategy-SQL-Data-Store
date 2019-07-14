CREATE PROCEDURE [dbo].[DeleteUserPermissions]
	@UserProfileId INT,
	@PermissionsId INT NULL
AS
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
