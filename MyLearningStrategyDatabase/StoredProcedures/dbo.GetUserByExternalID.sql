CREATE PROCEDURE [dbo].[GetUserByExternalID]
	@ExternalID  NVARCHAR (450),
	@IdentityProvider NVARCHAR(2083) NULL,
	@DisplayName  NVARCHAR (256) NULL
AS	


	IF NOT EXISTS (	SELECT * FROM UserProfiles WHERE ExternalID = @ExternalID AND IdentityProvider=@IdentityProvider)
	BEGIN
		INSERT INTO UserProfiles (ExternalID,DisplayName,IdentityProvider)
		VALUES (@ExternalID,@DisplayName,@IdentityProvider);
	END

	SELECT UserProfileId,ExternalID,DisplayName,EmailAddress,
	FirstName,LastName,PostalCode,IdentityProvider,
	Originator,ImageDevice,ImageCloud,ImageHash,
	HasLoggedIn,IsLocked,IsDisabled,IsDeleted,
	LastModifiedOffset
	FROM UserProfiles 
	WHERE ExternalID = @ExternalID;
RETURN
