CREATE PROCEDURE [dbo].[UpdateUserPermissions]
	@PermissionsId INT,
    @Originator UNIQUEIDENTIFIER,
	@ClaimType     NVARCHAR (250),
    @ClaimValue    NVARCHAR (250)

AS

	DECLARE @UserProfileId INT
	DECLARE @rowsaffected INT 

	SET @UserProfileId=[dbo].[OriginatorToUserId](@Originator)

	IF (@UserProfileId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserPermissions].@UserProfileId');   
	END


	BEGIN
		UPDATE [dbo].[UserPermissions]
		SET ClaimType=@ClaimType,
			ClaimValue=@ClaimValue
		WHERE PermissionsId =@PermissionsId
			AND UserProfileId =@UserProfileId;

		SET @rowsaffected = @@ROWCOUNT
	END

RETURN @rowsaffected
