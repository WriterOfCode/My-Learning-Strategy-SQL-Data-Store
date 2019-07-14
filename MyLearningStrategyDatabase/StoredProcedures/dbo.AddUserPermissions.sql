CREATE PROCEDURE [dbo].[AddUserPermissions]
    @Originator UNIQUEIDENTIFIER,
	@ClaimType     NVARCHAR (250),
    @ClaimValue    NVARCHAR (250)

AS
	DECLARE @PermissionsId AS INT
	DECLARE @UserProfileId AS INT
	
	SET @UserProfileId=[dbo].[OriginatorToUserId](@Originator)

	BEGIN
		INSERT INTO [dbo].[UserPermissions] (UserProfileId,ClaimType,ClaimValue)
		VALUES (@UserProfileId,@ClaimType,@ClaimValue)

		--SET @PermissionsId = CAST(SCOPE_IDENTITY() AS INT)
		SELECT CAST(SCOPE_IDENTITY() AS INT) AS PermissionsId;
	END

RETURN @PermissionsId
