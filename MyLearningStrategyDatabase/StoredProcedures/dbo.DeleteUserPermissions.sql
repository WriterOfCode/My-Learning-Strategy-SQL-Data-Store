CREATE PROCEDURE [dbo].[DeleteUserPermissions]
	@PermissionsId INT NULL,
    @Originator UNIQUEIDENTIFIER
AS

	DECLARE @UserProfileId INT
	DECLARE @rowsaffected INT 

	SET @UserProfileId=[dbo].[OriginatorToUserId](@Originator)

	IF (@UserProfileId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserPermissions].@UserProfileId');   
	END

	IF (@PermissionsId IS NULL)
		BEGIN
			DELETE
			FROM [dbo].[UserPermissions]
			WHERE UserProfileId = @UserProfileId;
			SET @rowsaffected = @@ROWCOUNT
		END
	ELSE
		BEGIN 
			DELETE
			FROM [dbo].[UserPermissions]
			WHERE UserProfileId = @UserProfileId
			AND  PermissionsId = @PermissionsId;
			SET @rowsaffected = @@ROWCOUNT
		END
RETURN @rowsaffected
