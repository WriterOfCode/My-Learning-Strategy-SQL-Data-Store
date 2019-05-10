CREATE PROCEDURE [dbo].[AddUserPermissions]
    @Originator UNIQUEIDENTIFIER,
	@ClaimType     NVARCHAR (250),
    @ClaimValue    NVARCHAR (250)

AS
	DECLARE @PermissionsId AS INT
	DECLARE @UserProfileId AS INT
	
	SET @UserProfileId=[dbo].[OriginatorToUserId](@Originator)

	IF (@UserProfileId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserPermissions].@UserProfileId');   
	END
	IF (@ClaimType IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserPermissions.@ClaimType');   
	END
	IF (@ClaimValue IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserPermissions].@ClaimValue');   
	END

	BEGIN

	INSERT INTO [dbo].[UserPermissions] (UserProfileId,ClaimType,ClaimValue)
	VALUES (@UserProfileId,@ClaimType,@ClaimValue)

	SELECT CAST(SCOPE_IDENTITY() AS INT) AS PermissionsId;
	END

RETURN @PermissionsId
