CREATE PROCEDURE [dbo].[GetUserProfile]
	@ExternalID NVARCHAR(450) NULL,
	@IdentityProvider NVARCHAR(2083) NULL, 
	@Originator UNIQUEIDENTIFIER NULL
AS
IF (@ExternalID IS NULL AND @Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'Both GetUserProfile profile pramiters can not be null');   
END

IF (@Originator IS NOT NULL)
	BEGIN
		SELECT UserProfileId,ExternalID,DisplayName,EmailAddress,
			FirstName,LastName,PostalCode,IdentityProvider,
			Originator,ImageDevice,ImageCloud,ImageHash,
			HasLoggedIn,IsLocked,IsDisabled,IsDeleted,
			LastModifiedOffset
		FROM UserProfiles 
		WHERE Originator = @Originator;
	END
ELSE IF (@ExternalID IS NOT NULL AND @IdentityProvider IS NOT NULL)
	BEGIN
		SELECT UserProfileId,ExternalID,DisplayName,EmailAddress,
			FirstName,LastName,PostalCode,IdentityProvider,
			Originator,ImageDevice,ImageCloud,ImageHash,
			HasLoggedIn,IsLocked,IsDisabled,IsDeleted,
			LastModifiedOffset
		FROM UserProfiles 
		WHERE ExternalID = @ExternalID
		AND IdentityProvider=@IdentityProvider;
	END
RETURN